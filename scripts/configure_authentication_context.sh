#!/bin/sh



# Function to authenticate and get the access token for Microsoft Graph API
get_access_token() {
  #echo "Authenticating with Azure CLI..."

  az login --service-principal --username "$ARM_CLIENT_ID" --password "$ARM_CLIENT_SECRET" --tenant "$ARM_TENANT_ID" --allow-no-subscriptions > /dev/null 2>&1

  AccessToken=$(az account get-access-token --resource https://graph.microsoft.com --query accessToken -o tsv) 

  if [ -z "$AccessToken" ]; then
    #echo "Error: Unable to obtain an access token."
    exit 1
  fi

  #echo "Successfully obtained access token."
}

# Function to update the role management policy rule using Microsoft Graph API
update_role_management_policy_rule() {
  #echo "Updating role management policy rule..."
  #echo "Claim Value: $ClaimValue"
  #echo "Rule ID: $UnifiedRoleManagementPolicyRuleId"

  # Prepare the JSON payload
  json_payload=$(cat <<EOF
{
   "@odata.type": "#microsoft.graph.unifiedRoleManagementPolicyAuthenticationContextRule",
   "id": "AuthenticationContext_EndUser_Assignment",
   "isEnabled": true,
   "claimValue": "$ClaimValue",
   "target": {
     "caller": "EndUser",
     "operations": [
     "all"
     ],
     "level": "Assignment",
     "inheritableSettings": [],
     "enforcedSettings": []
   }
 }
EOF
)

  url="https://graph.microsoft.com/v1.0/policies/roleManagementPolicies/$UnifiedRoleManagementPolicyRuleId/rules/AuthenticationContext_EndUser_Assignment"
  #echo "URL: $url"
  #echo "Payload: $json_payload"
  # Make the PATCH request to update the role management policy rule
  response=$(az rest --method PATCH \
    --url "$url" \
    --headers "Authorization=Bearer $AccessToken" \
    --body "$json_payload" 2>&1)

  if [ $? -ne 0 ]; then
    #echo "Error: Failed to update role management policy rule. Response: $response"
    exit 1
  fi

  #echo "Role management policy rule updated successfully."
}




# Validate environment variables
if [ -z "$ClaimValue" ] || [ -z "$UnifiedRoleManagementPolicyRuleId" ]; then
  #echo "Error: Environment variables 'ClaimValue' and 'UnifiedRoleManagementPolicyRuleId' must be set."
  exit 1
fi

# Ensure necessary commands are installed


# Authenticate and get the access token
get_access_token

# Update the role management policy rule
update_role_management_policy_rule

#echo "Script completed successfully."
