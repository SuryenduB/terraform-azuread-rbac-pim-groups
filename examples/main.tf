variable "groups" {
  type = list(
    object({
      # Required parameter
      pim_group_display_name = string

      # Optional parameters with defaults
      user_emails                                                    = optional(list(string))
      require_multifactor_authentication_to_activate                 = optional(bool)
      required_conditional_access_authentication_context_claim_value = optional(string)
      pim_approver_group_object_id                                   = optional(string)
      require_approval_to_activate                                   = optional(bool)
      require_justification_to_activate                              = optional(bool)
      require_ticket_to_activate                                     = optional(bool)
      allow_permanent_active_assignment                              = optional(bool)
      allow_permanent_eligible_assignment                            = optional(bool)
      activation_maximum_duration                                    = optional(string)
      eligible_assignment_duration                                   = optional(string)
      notification_level                                             = optional(string)
      additional_notification_recipients                             = optional(list(string), [])
      assigned_roles                                                 = optional(list(string), [])
    })
  )
  description = "List of PIM group configurations"
  default     = []
}

# main.tf


module "rbac_pag" {
  for_each = { for idx, group in var.groups : idx => group }
  source   = "./modules/rbac_pag"

  # Required parameter
  pim_group_display_name = each.value.pim_group_display_name

  # Optional parameters with coalesce for default handling
  user_emails                                                    = coalesce(each.value.user_emails, [])
  require_multifactor_authentication_to_activate                 = coalesce(each.value.require_multifactor_authentication_to_activate, true)
  required_conditional_access_authentication_context_claim_value = lookup(each.value, "required_conditional_access_authentication_context_claim_value", "c1")
  pim_approver_group_object_id                                   = coalesce(each.value.pim_approver_group_object_id, "07f260f5-c680-4069-8da8-8f2b780ee107")
  require_approval_to_activate                                   = coalesce(each.value.require_approval_to_activate, false)
  require_justification_to_activate                              = coalesce(each.value.require_justification_to_activate, true)
  require_ticket_to_activate                                     = coalesce(each.value.require_ticket_to_activate, true)
  allow_permanent_active_assignment                              = coalesce(each.value.allow_permanent_active_assignment, false)
  allow_permanent_eligible_assignment                            = coalesce(each.value.allow_permanent_eligible_assignment, false)
  activation_maximum_duration                                    = coalesce(each.value.activation_maximum_duration, "PT8H")
  eligible_assignment_duration                                   = coalesce(each.value.eligible_assignment_duration, "P365D")
  notification_level                                             = coalesce(each.value.notification_level, "All")
  additional_notification_recipients                             = coalesce(each.value.additional_notification_recipients, [])
  assigned_roles                                                 = coalesce(each.value.assigned_roles, [])
}
