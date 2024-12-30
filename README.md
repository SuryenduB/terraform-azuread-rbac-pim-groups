<!-- BEGIN_TF_DOCS -->
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
| pim\_approver\_group\_object\_id | The object id of the PIM approver group | `string` | `"07f260f5-c680-4069-8da8-8f2b780ee107"` | no |
| require\_approval\_to\_activate | Specify if approval for activation of an eligible assignment is required. If Yes you need to provide approver group | `bool` | `false` | no |
| require\_justification\_active\_assignment | You can require that users enter a business justification when they create an active (as opposed to eligible) assignment. | `bool` | `true` | no |
| require\_justification\_to\_activate | Specify if require users to enter a business justification when they activate the eligible assignment. | `bool` | `true` | no |
| require\_multifactor\_authentication\_active\_assignment | Specify if an administrator or group owner provides multifactor authentication when they create an active (as opposed to eligible) assignment. | `bool` | `true` | no |
| require\_multifactor\_authentication\_to\_activate | Specify if Multi Factor Authentication for activation of an eligible assignment is required. Set to False if you want to disable MFA for activation or Use authentication context | `bool` | `true` | no |
| require\_ticket\_information\_active\_assignment | Indicates if ticket information is required for activation | `bool` | `true` | no |
| require\_ticket\_to\_activate | Specify if require users to enter a support ticket when they activate the eligible assignment. | `bool` | `true` | no |
| required\_conditional\_access\_authentication\_context\_claim\_value | Specify if approval for activation of an eligible assignment is required. If Yes you need to provide approver group | `string` | `""` | no |
| user\_emails | List of user emails to be added to the PIM Group | `list(string)` | <pre>[<br>  "suryendub@03z3s.onmicrosoft.com"<br>]</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| pimgroup1\_id | n/a |
<!-- END_TF_DOCS -->