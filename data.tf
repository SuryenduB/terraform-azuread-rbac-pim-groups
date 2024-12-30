locals {
  user_ids = [
    for email in var.user_emails : data.azuread_user.user[email].id
  ]
}

data "azuread_user" "user" {
  for_each            = toset(var.user_emails)
  user_principal_name = each.value
}

data "azuread_group" "pimapprover" {
  count            = var.pim_approver_group_object_id != null ? 1 : 0
  security_enabled = true
  object_id        = var.pim_approver_group_object_id
}