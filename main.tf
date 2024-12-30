resource "azuread_group_role_management_policy" "pimpolicy1" {
  group_id = split("/", azuread_group.pimgroup1.id)[2]
  role_id  = "member"

  activation_rules {
    maximum_duration                   = var.activation_maximum_duration
    require_justification              = var.require_justification_to_activate
    require_ticket_info                = var.require_ticket_to_activate
    require_multifactor_authentication = var.require_multifactor_authentication_to_activate ? "true" : null
    require_approval                   = var.require_approval_to_activate
    dynamic "approval_stage" {
      for_each = var.require_approval_to_activate && var.pim_approver_group_object_id != null ? [1] : []
      content {
        primary_approver {
          object_id = split("/", data.azuread_group.pimapprover[0].id)[2]
          type      = "groupMembers"
        }
      }


    }

  }

  active_assignment_rules {
    expiration_required                = var.allow_permanent_active_assignment
    expire_after                       = var.allow_permanent_active_assignment ? var.active_assignment_duration : null
    require_justification              = var.require_justification_active_assignment
    require_multifactor_authentication = var.require_multifactor_authentication_active_assignment
  }

  eligible_assignment_rules {
    expiration_required = var.allow_permanent_eligible_assignment
    expire_after        = var.allow_permanent_eligible_assignment ? var.eligible_assignment_duration : null

  }

  notification_rules {
    eligible_assignments {
      approver_notifications {
        notification_level    = var.notification_level
        default_recipients    = var.enable_default_notification_recipients
        additional_recipients = var.additional_notification_recipients
      }
      admin_notifications {
        notification_level    = var.notification_level
        default_recipients    = var.enable_default_notification_recipients
        additional_recipients = var.additional_notification_recipients
      }
      assignee_notifications {
        notification_level    = var.notification_level
        default_recipients    = var.enable_default_notification_recipients
        additional_recipients = var.additional_notification_recipients
      }
    }
    active_assignments {
      approver_notifications {
        notification_level    = var.notification_level
        default_recipients    = var.enable_default_notification_recipients
        additional_recipients = var.additional_notification_recipients
      }
      admin_notifications {
        notification_level    = var.notification_level
        default_recipients    = var.enable_default_notification_recipients
        additional_recipients = var.additional_notification_recipients
      }
      assignee_notifications {
        notification_level    = var.notification_level
        default_recipients    = var.enable_default_notification_recipients
        additional_recipients = var.additional_notification_recipients
      }

    }
    eligible_activations {
      approver_notifications {
        notification_level = var.notification_level
        default_recipients = var.enable_default_notification_recipients

      }
      admin_notifications {
        notification_level    = var.notification_level
        default_recipients    = var.enable_default_notification_recipients
        additional_recipients = var.additional_notification_recipients
      }
      assignee_notifications {
        notification_level    = var.notification_level
        default_recipients    = var.enable_default_notification_recipients
        additional_recipients = var.additional_notification_recipients
      }

    }

  }

}


resource "azuread_privileged_access_group_eligibility_schedule" "assignment" {

  for_each             = toset(local.user_ids)
  group_id             = split("/", azuread_group.pimgroup1.id)[2]
  principal_id         = split("/", each.value)[2]
  assignment_type      = "member"
  duration             = var.eligible_assignment_duration
  permanent_assignment = var.allow_permanent_eligible_assignment && var.permanent_eligible_assignment

}


