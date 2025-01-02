resource "azuread_group" "pimgroup1" {
  display_name            = var.pim_group_display_name
  security_enabled        = true
  assignable_to_role      = true
  prevent_duplicate_names = true
}
