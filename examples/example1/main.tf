module "rbac-pim-groups" {
  source  = "SuryenduB/rbac-pim-groups/azuread"
  version = "0.0.10"
  # insert the 1 required variable here
  pim_group_display_name = "glob_gsec_pim_admin_roles_teams_administrators"

}
