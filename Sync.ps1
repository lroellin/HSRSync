# Include library
. ".\Library.ps1" 

$NetworkDrive = "\\hsr.ch\root"
$NetworkDriveLetter = "Y"
$BasePathSource = "${NetworkDriveLetter}:\alg\skripte"
$BasePathDestination = "C:\HSR\Sync"
$VPNHost = "vpn.hsr.ch"
$DefaultVPNUsername = "lroellin"
$VPNTestHost = "skripte.hsr.ch"
$VPNWait = 10 

Write-Step -Message "Checking network connection"
If(!(Test-Connection -ComputerName $VPNTestHost -Quiet -Count 1)) {
    Write-Step -Message "Not connected. Connecting to VPN..."
    $NetworkCredentials = Get-Credential -Credential $DefaultVPNUsername
    $VPNPassword = $NetworkCredentials.GetNetworkCredential().Password
    $VPNUsername = $NetworkCredentials.GetNetworkCredential().UserName
    & .\VPN.ps1 -CiscoVPNHost $VPNHost -Login $VPNUsername -Password $VPNPassword
    Write-Host "Waiting a bit..."
    Sleep $VPNWait
    If(!(Test-Connection -ComputerName $VPNTestHost -Quiet -Count 1)) {
        Write-Error "VPN not connected. Check the error in the command window in the background, or increase `$VPNWait if the connection takes longer to establish."
        Pause-Script 
        Exit
    }
    Write-Success -Message "Connected to VPN."
} Else {
    Write-Success "Connected."
}

Write-Step -Message "Mapping network drive..."
New-PSDrive -Name "Y" -PSProvider FileSystem -Root $NetworkDrive -Persist -ErrorAction SilentlyContinue
Write-Success -Message "Mapped."

# Module
$ModulePaths = "Informatik\Fachbereich\Algorithmen_und_Datenstrukturen_2", "Informatik\Fachbereich\C++", "Informatik\Fachbereich\Computernetze_1", "Informatik\Fachbereich\Informations-_und_Codierungstheorie"

Write-Step -Message "Syncing..."
$StartTime = Get-Date
Foreach($ModulePath in $ModulePaths) {
    # Using only last part of module path for the local name
    $Name = Split-Path -Path $ModulePath -Leaf
    $SyncSource = Join-Path -Path $BasePathSource -ChildPath $ModulePath
    $SyncDestination = Join-Path $BasePathDestination -ChildPath $Name
    if(-Not (Test-Path $SyncSource))
    {
        Write-Error "Module $Name at $SyncSource not found"
        Pause-Script
        Exit
    }
    TestCreate-Directory -Dir $SyncDestination
    Write-Host "Syncing $Name"
    Start-Process -FilePath "Robocopy.exe" -ArgumentList "`"$SyncSource`" `"$SyncDestination`" /MIR /eta /ndl /njh /njs" -NoNewWindow -Wait
}
Write-Success -Message "Synced."

Remove-PSDrive $NetworkDriveLetter

$EndTime = Get-Date
$TimeDifference = New-TimeSpan -Start $StartTime -End $EndTime

# Notification
# by https://gist.github.com/altrive/72594b8427b2fff16431
$Notification = "HSR Sync`r`nSynced in $($TimeDifference.Seconds)s"
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
$template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)
#Convert to .NET type for XML manipuration
$toastXml = [xml] $template.GetXml()
$toastXml.GetElementsByTagName("text").AppendChild($toastXml.CreateTextNode($Notification)) > $null
#Convert back to WinRT type
$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml($toastXml.OuterXml)
$toast = [Windows.UI.Notifications.ToastNotification]::new($xml)
$toast.Tag = "PowerShell"
$toast.Group = "PowerShell"
$toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes(5)
#$toast.SuppressPopup = $true
$notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("PowerShell")
$notifier.Show($toast);