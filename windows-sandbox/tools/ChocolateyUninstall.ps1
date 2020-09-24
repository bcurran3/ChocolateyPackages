$ErrorActionPreference = 'Stop'
$packageName = 'windows-sandbox'

Disable-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM -NoRestart
