$ErrorActionPreference = 'Stop'
$packageName = 'wsl'

Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart |Out-Null
