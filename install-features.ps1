# Install required Windows features
Install-WindowsFeature -Name Web-Server, DHCP, Windows-Server-Backup -IncludeManagementTools

# Configure DHCP server
Add-DhcpServerv4Scope -Name "Default Scope" -StartRange 192.168.1.100 -EndRange 192.168.1.200 -SubnetMask 255.255.255.0

# Enable DHCP server
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\DHCPServer" -Name Start -Value 2

# Create a backup configuration
$backupTarget = New-WBBackupTarget -VolumePath "C:"
$policy = New-WBPolicy
Add-WBSystemState -Policy $policy
Add-WBBackupTarget -Policy $policy -Target $backupTarget

# Write completion status to a log file
$logFile = "C:\Windows\Temp\feature-installation.log"
Add-Content -Path $logFile -Value "Installation completed at $(Get-Date)"