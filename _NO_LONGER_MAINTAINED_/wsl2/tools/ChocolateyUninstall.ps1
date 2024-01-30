$ErrorActionPreference = 'Stop'
$packageName = 'wsl2'

Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart |Out-Null
