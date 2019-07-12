$ErrorActionPreference = 'Stop'
$packageName = 'windows-sandbox'

$test=(Get-WindowsOptionalFeature -Featurename "Containers-DisposableClientVM" -Online)
if (!$test) {
    Write-Warning "Unsupported Operating System. Windows 10 Pro or Enterprise 1903 or greater required."
	throw
	}
if ($test.state = 'Enabled') {
    Write-Host "  ** Sandbox already installed!" -Foreground Magenta
	return
	} else {
	  Enable-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM -NoRestart
	  }
