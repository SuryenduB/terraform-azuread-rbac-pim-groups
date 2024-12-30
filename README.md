<!-- BEGIN_TF_DOCS -->


## Example

```hcl
module "rbac-pim-groups" {
  source  = "SuryenduB/rbac-pim-groups/azuread"
  version = "0.0.9"
  # insert the 1 required variable here
  pim_group_display_name = "glob_gsec_pim_admin_roles_teams_administrators"

}
```
```hcl


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
  default = [



    {
      #displayName value
      pim_group_display_name = "glob_gsec_pim_admin_roles_intune_read_only_administrators"

      # The maximum duration for an active assignment. maximum time, in hours, that an activation request for a role assignment remains active before it expires. This value can be from one to 24 hours.
      activation_maximum_duration = "PT16H"

      # This setting specifies the duration of the active assignment.Resource administrators can require that all active assignments have a specified start and end date. If Permanent active assignment is disabled
      active_assignment_duration = false

      # Specify any additional recipients who should receive these notifications. You can turn off emails sent to additional recipients by setting this to empty array.
      additional_notification_recipients = ["HenriettaM@03z3s.onmicrosoft.com", "IsaiahL@03z3s.onmicrosoft.com"]

      # Resource administrators can assign permanent active assignments.
      allow_permanent_active_assignment = false

      # Resource administrators can assign permanent eligible assignments.
      allow_permanent_eligible_assignment = false

      # This setting specifies the duration of the eligible assignment.Resource administrators can require that all eligible assignments have a specified start and end date. If Permanent active assignment is disabled
      eligible_assignment_duration = "P365D"

      # Specify Should the default recipients receive these notifications. You can turn off emails sent to default recipients by setting this to false.
      enable_default_notification_recipients = true

      # Critical or All notifications.  For each type of email, you can set this to `Critical` to receive critical emails only.
      notification_level = "All"

      # Specify if the Eligible assignment is permanent
      permanent_eligible_assignment = false

      # The object id of the PIM approver group
      pim_approver_group_object_id = "07f260f5-c680-4069-8da8-8f2b780ee107"

      # Specify if approval for activation of an eligible assignment is required. If Yes you need to provide approver group
      require_approval_to_activate = false

      # You can require that users enter a business justification when they create an active (as opposed to eligible) assignment.
      require_justification_active_assignment = true

      # Specify if require users to enter a business justification when they activate the eligible assignment.
      require_justification_to_activate = true

      # Specify if an administrator or group owner provides multifactor authentication when they create an active (as opposed to eligible) assignment.
      require_multifactor_authentication_active_assignment = true

      # Specify if Multi Factor Authentication for activation of an eligible assignment is required. Set to False if you want to disable MFA for activation or Use authentication context
      require_multifactor_authentication_to_activate = true

      # Indicates if ticket information is required for activation
      require_ticket_information_active_assignment = true

      # Specify if require users to enter a support ticket when they activate the eligible assignment.
      require_ticket_to_activate = true

      # Specify if approval for activation of an eligible assignment is required. If Yes you need to provide approver group
      required_conditional_access_authentication_context_claim_value = ""

      # List of user emails to be added to the PIM Group
      user_emails = [
        "suryendub@03z3s.onmicrosoft.com",
        "IsaiahL@03z3s.onmicrosoft.com",
        "AlexW@03z3s.onmicrosoft.com",
      ]

      assigned_roles = [
        "Security administrator",
      ]

    }
  ]
}

# main.tf


module "rbac_pag" {
  for_each = { for idx, group in var.groups : idx => group }
  source   = "SuryenduB/rbac-pim-groups/azuread"
  version  = "0.0.9"

  # Required parameter
  pim_group_display_name = each.value.pim_group_display_name

  # Optional parameters with coalesce for default handling
  user_emails                                                    = coalesce(each.value.user_emails, [])
  require_multifactor_authentication_to_activate                 = coalesce(each.value.require_multifactor_authentication_to_activate, true)
  required_conditional_access_authentication_context_claim_value = lookup(each.value, "required_conditional_access_authentication_context_claim_value", "c1")
  pim_approver_group_object_id                                   = coalesce(each.value.pim_approver_group_object_id, null)
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
```


### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| pim\_group\_display\_name | value | `string` | n/a | yes |
| activation\_maximum\_duration | The maximum duration for an active assignment. maximum time, in hours, that an activation request for a role assignment remains active before it expires. This value can be from one to 24 hours. | `string` | `"PT8H"` | no |
| active\_assignment\_duration | This setting specifies the duration of the active assignment.Resource administrators can require that all active assignments have a specified start and end date. If Permanent active assignment is disabled | `bool` | `false` | no |
| additional\_notification\_recipients | Specify any additional recipients who should receive these notifications. You can turn off emails sent to additional recipients by setting this to empty array. | `list(string)` | `[]` | no |
| allow\_permanent\_active\_assignment | Resource administrators can assign permanent active assignments. | `bool` | `false` | no |
| allow\_permanent\_eligible\_assignment | Resource administrators can assign permanent eligible assignments. | `bool` | `false` | no |
| assigned\_roles | Specify roles assigned to the groups for Privilege Access | `list(string)` | `[]` | no |
| eligible\_assignment\_duration | This setting specifies the duration of the eligible assignment.Resource administrators can require that all eligible assignments have a specified start and end date. If Permanent active assignment is disabled | `string` | `"P365D"` | no |
| enable\_default\_notification\_recipients | Specify Should the default recipients receive these notifications. You can turn off emails sent to default recipients by setting this to false. | `bool` | `true` | no |
| notification\_level | Critical or All notifications.  For each type of email, you can set this to `Critical` to receive critical emails only. | `string` | `"All"` | no |
| permanent\_eligible\_assignment | Specify if the Eligible assignment is permanent | `bool` | `false` | no |
| pim\_approver\_group\_object\_id | The object id of the PIM approver group | `string` | `null` | no |
| require\_approval\_to\_activate | Specify if approval for activation of an eligible assignment is required. If Yes you need to provide approver group | `bool` | `false` | no |
| require\_justification\_active\_assignment | You can require that users enter a business justification when they create an active (as opposed to eligible) assignment. | `bool` | `true` | no |
| require\_justification\_to\_activate | Specify if require users to enter a business justification when they activate the eligible assignment. | `bool` | `true` | no |
| require\_multifactor\_authentication\_active\_assignment | Specify if an administrator or group owner provides multifactor authentication when they create an active (as opposed to eligible) assignment. | `bool` | `true` | no |
| require\_multifactor\_authentication\_to\_activate | Specify if Multi Factor Authentication for activation of an eligible assignment is required. Set to False if you want to disable MFA for activation or Use authentication context | `bool` | `true` | no |
| require\_ticket\_information\_active\_assignment | Indicates if ticket information is required for activation | `bool` | `true` | no |
| require\_ticket\_to\_activate | Specify if require users to enter a support ticket when they activate the eligible assignment. | `bool` | `true` | no |
| required\_conditional\_access\_authentication\_context\_claim\_value | Specify if approval for activation of an eligible assignment is required. If Yes you need to provide approver group | `string` | `""` | no |
| user\_emails | List of user emails to be added to the PIM Group | `list(string)` | `[]` | no |
### Outputs

| Name | Description |
|------|-------------|
| pimgroup1\_id | n/a | 
<!-- END_TF_DOCS -->