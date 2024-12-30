module "role_assignment" {
  for_each                   = { for idx, assigned_role in var.assigned_roles : idx => assigned_role }
  source                     = "../role_assignment"
  principal_object_id        = split("/", azuread_group.pimgroup1.id)[2]
  assigned_roles_displayname = each.value

}