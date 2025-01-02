resource "azuread_directory_role" "assigned" {
  display_name = var.assigned_roles_displayname
}

resource "azuread_directory_role_assignment" "pim_assigned_role" {

  role_id             = azuread_directory_role.assigned.template_id
  principal_object_id = var.principal_object_id
}
