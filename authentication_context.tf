resource "null_resource" "configure_authentication_context" {
  triggers = {
    random_value = length(var.required_conditional_access_authentication_context_claim_value) != 0 && !var.require_multifactor_authentication_to_activate ? timestamp() : azuread_group_role_management_policy.pimpolicy1.id # Generates a new UUID every time
  }
  count = length(var.required_conditional_access_authentication_context_claim_value) != 0 && !var.require_multifactor_authentication_to_activate ? 1 : 0
  provisioner "local-exec" {
    command = format("%s/scripts/configure_authentication_context.sh",
      path.module
    )
    interpreter = ["/bin/sh"]
    on_failure  = continue
    environment = {
      ClaimValue                        = lower(var.required_conditional_access_authentication_context_claim_value)
      UnifiedRoleManagementPolicyRuleId = azuread_group_role_management_policy.pimpolicy1.id
    }
  }

  depends_on = [azuread_group_role_management_policy.pimpolicy1]
}

