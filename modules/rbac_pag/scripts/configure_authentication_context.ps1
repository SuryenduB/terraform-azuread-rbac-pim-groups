
param(
    [string] $ClaimValue,
    [string] $UnifiedRoleManagementPolicyRuleId
)

# Function to load environment variables
function Get-EnvVariable {
    param (
        [Parameter(Mandatory=$true)]
        [string]$VarName
    )
    
    $envVar = [System.Environment]::GetEnvironmentVariable($VarName, [System.EnvironmentVariableTarget]::Process)
    
    if (-not $envVar) {
        Write-Error "Environment variable '$VarName' is not set."
        exit 1
    }

    return $envVar
}

function Install-MicrosoftGraphModule {
    $moduleName = "Microsoft.Graph"

    # Check if the module is already installed
    if (-not (Get-Module -ListAvailable -All -ErrorAction SilentlyContinue | Where-Object Name -Like $moduleName )) {
        Write-Host "Microsoft Graph PowerShell module not found. Installing..."
        try {
            # Install the module for the current user
            Install-PSResource -Name Microsoft.Graph -Scope CurrentUser -Force
            Write-Host "Microsoft Graph PowerShell module installed successfully."
        } catch {
            Write-Error "Failed to install Microsoft Graph PowerShell module: $_"
            exit 1
        }
    } else {
        Write-Host "Microsoft Graph PowerShell module is already installed."
    }
}

# Function to connect to Microsoft Graph
function Connect-MicrosoftGraph {
    try {
        # Load the necessary values from environment variables
        $ClientId = Get-EnvVariable -VarName "ARM_CLIENT_ID"
        $ClientSecret = Get-EnvVariable -VarName "ARM_CLIENT_SECRET"
        $TenantId = Get-EnvVariable -VarName "ARM_TENANT_ID"

        # Convert Client Secret to Secure String
        $SecureClientSecret = ConvertTo-SecureString -String $ClientSecret -AsPlainText -Force

        # Create a PSCredential object with the ClientId and SecureClientSecret
        $ClientSecretCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $ClientId, $SecureClientSecret

        # Connect to Microsoft Graph
        Connect-MgGraph -TenantId $TenantId -ClientSecretCredential $ClientSecretCredential

        Write-Host "Successfully connected to Microsoft Graph."

    } catch {
        Write-Error "An error occurred while connecting to Microsoft Graph: $_"
        exit 1
    }
}

# Function to verify the connection

# Main Script Execution
# Ensure the Microsoft Graph PowerShell module is installed
Install-MicrosoftGraphModule
Connect-MicrosoftGraph
$unifiedRoleManagementPolicyId = 'AuthenticationContext_EndUser_Assignment'
$params = @{
    '@odata.type'        = '#microsoft.graph.unifiedRoleManagementPolicyAuthenticationContextRule'
    id                   = 'AuthenticationContext_EndUser_Assignment'
    isExpirationRequired = $true
    isEnabled            = 'true'
    claimValue           = $ClaimValue
    target               = @{
        caller              = 'EndUser'
        operation           = @('All')
    
        level               = 'Assignment'
        inheritableSettings = @(
        )
        enforcedSettings    = @(
        )
    }
}


Update-MgPolicyRoleManagementPolicyRule -UnifiedRoleManagementPolicyId $unifiedRoleManagementPolicyId -UnifiedRoleManagementPolicyRuleId $unifiedRoleManagementPolicyRuleId -BodyParameter $params