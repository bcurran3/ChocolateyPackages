$ErrorActionPreference = 'Stop'
$packageName = 'windowssandbox'

Disable-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM -NoRestart |Out-Null
