variable "groups" {
  type = list(
    object({
      # Required parameter
      pim_group_display_name = string

      # Optional parameters with defaults
      user_emails                                                    = optional(list(string), [])
      require_multifactor_authentication_to_activate                 = optional(bool, true)
      required_conditional_access_authentication_context_claim_value = optional(string, "")
      pim_approver_group_object_id                                   = optional(string, "07f260f5-c680-4069-8da8-8f2b780ee107")
      require_approval_to_activate                                   = optional(bool, false)
      require_justification_to_activate                              = optional(bool, true)
      require_ticket_to_activate                                     = optional(bool, true)
      allow_permanent_active_assignment                              = optional(bool, false)
      allow_permanent_eligible_assignment                            = optional(bool, false)
      activation_maximum_duration                                    = optional(string, "PT8H")
      eligible_assignment_duration                                   = optional(string, "P365D")
      notification_level                                             = optional(string, "All")
      additional_notification_recipients                             = optional(list(string), [])
      assigned_roles                                                 = optional(list(string), [])
    })
  )
  description = "List of PIM group configurations"
  default     = []
}
