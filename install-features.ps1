# Login to Azure
Connect-AzAccount

# Create Resource Group
$resourceGroupName = "WinServer2019-RG"
New-AzResourceGroup -Name $resourceGroupName -Location "australiaeast"

# Deploy the template
$templateFile = "server2019-deployment.json"
$deploymentName = "WinServer2019Deployment-" + (Get-Date).ToString("yyyyMMdd-HHmmss")

# Replace with your script's actual URL
$scriptUri = "https://your-storage-account.blob.core.windows.net/scripts/install-features.ps1"

$params = @{
    vmName = "WinServer2019"
    adminUsername = "adminron"
    adminPassword = (ConvertTo-SecureString -String "qwerty654321!" -AsPlainText -Force)
    scriptFileUri = $scriptUri
}

New-AzResourceGroupDeployment `
    -Name $deploymentName `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile $templateFile `
    -TemplateParameterObject $params