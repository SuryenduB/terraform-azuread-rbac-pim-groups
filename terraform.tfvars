groups = [
  {
    pim_group_display_name                                         = "glob_gsec_pim_admin_roles_network"
    require_multifactor_authentication_to_activate                 = false
    required_conditional_access_authentication_context_claim_value = "c1"
  },
  {
    pim_group_display_name                         = "glob_gsec_pim_admin_roles_bitlocker_key_readers"
    require_multifactor_authentication_to_activate = true
  },
  {
    pim_group_display_name                                         = "glob_gsec_pim_admin_roles_soc"
    user_emails                                                    = ["AlexW@03z3s.onmicrosoft.com"]
    required_conditional_access_authentication_context_claim_value = "c1"
    require_multifactor_authentication_to_activate                 = false
  },
  {


    #displayName value
    pim_group_display_name = "glob_gsec_pim_admin_roles_workplace"

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
