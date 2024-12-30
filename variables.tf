variable "user_emails" {
  description = "List of user emails to be added to the PIM Group"
  type        = list(string)
  default     = []
}

variable "pim_group_display_name" {
  description = "value"
  type        = string
  validation {

    condition     = can(regex("^(glob|hu|us|ua|de)_gsec_pim_admin_roles_.*$", var.pim_group_display_name))
    error_message = "The value must match the pattern ^(glob|hu|us|ua|de)_gsec_pim_admin_roles_.*$ Example : glob_gsec_pim_admin_roles_xyz"
  }
}

variable "pim_approver_group_object_id" {
  description = "The object id of the PIM approver group"
  type        = string
  default     = null
  validation {
    condition     = var.pim_approver_group_object_id == null || can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.pim_approver_group_object_id))
    error_message = "Object ID must be a valid GUID"
  }
}

variable "require_approval_to_activate" {
  description = "Specify if approval for activation of an eligible assignment is required. If Yes you need to provide approver group"
  type        = bool
  default     = false
}

variable "require_justification_to_activate" {
  description = "Specify if require users to enter a business justification when they activate the eligible assignment."
  type        = bool
  default     = true
}

variable "require_ticket_to_activate" {
  description = "Specify if require users to enter a support ticket when they activate the eligible assignment."
  type        = bool
  default     = true
}

variable "require_multifactor_authentication_to_activate" {
  description = "Specify if Multi Factor Authentication for activation of an eligible assignment is required. Set to False if you want to disable MFA for activation or Use authentication context"
  type        = bool
  default     = true
}

variable "required_conditional_access_authentication_context_claim_value" {
  description = "Specify if approval for activation of an eligible assignment is required. If Yes you need to provide approver group"
  type        = string
  default     = ""
}
variable "allow_permanent_active_assignment" {
  description = "Resource administrators can assign permanent active assignments."
  type        = bool
  default     = false

}

variable "allow_permanent_eligible_assignment" {
  description = "Resource administrators can assign permanent eligible assignments."
  type        = bool
  default     = false

}

variable "require_ticket_information_active_assignment" {
  description = "Indicates if ticket information is required for activation"
  type        = bool
  default     = true
}

variable "require_justification_active_assignment" {
  description = "You can require that users enter a business justification when they create an active (as opposed to eligible) assignment."
  type        = bool
  default     = true
}

variable "require_multifactor_authentication_active_assignment" {
  description = "Specify if an administrator or group owner provides multifactor authentication when they create an active (as opposed to eligible) assignment."
  type        = bool
  default     = true
}

variable "activation_maximum_duration" {
  description = "The maximum duration for an active assignment. maximum time, in hours, that an activation request for a role assignment remains active before it expires. This value can be from one to 24 hours."
  type        = string
  default     = "PT8H"
  validation {
    condition     = can(regex("^PT(1[0-9]|2[0-4]|[1-9])H$", var.activation_maximum_duration))
    error_message = "The value must be in the format PTnH where n is between 1 and 9"
  }

}
variable "active_assignment_duration" {
  description = "This setting specifies the duration of the active assignment.Resource administrators can require that all active assignments have a specified start and end date. If Permanent active assignment is disabled"
  type        = bool
  default     = false
}

variable "eligible_assignment_duration" {
  description = "This setting specifies the duration of the eligible assignment.Resource administrators can require that all eligible assignments have a specified start and end date. If Permanent active assignment is disabled"
  type        = string
  validation {
    condition     = can(regex("^P(3[0-5][0-9]|36[0-5]|[1-9][0-9]?|(1[0-9]{2}|2[0-9]{2}|300)|[1-9])D$", var.eligible_assignment_duration))
    error_message = "The value must be in the format PnD where n is between 1 and 365"
  }
  default = "P365D"
}

variable "notification_level" {
  description = "Critical or All notifications.  For each type of email, you can set this to `Critical` to receive critical emails only."
  type        = string
  default     = "All"
}

variable "enable_default_notification_recipients" {
  description = "Specify Should the default recipients receive these notifications. You can turn off emails sent to default recipients by setting this to false."
  type        = bool
  default     = true
}

variable "additional_notification_recipients" {
  description = "Specify any additional recipients who should receive these notifications. You can turn off emails sent to additional recipients by setting this to empty array."
  type        = list(string)
  default     = []
}


variable "permanent_eligible_assignment" {
  description = "Specify if the Eligible assignment is permanent"
  type        = bool
  default     = false
}

variable "assigned_roles" {
  description = "Specify roles assigned to the groups for Privilege Access"
  type        = list(string)
  default     = []

}
