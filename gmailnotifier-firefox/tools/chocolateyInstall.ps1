$packageName = 'gmailnotifier-firefox'
$url         = 'https://addons.cdn.mozilla.net/user-media/addons/406178/gmailtm_notifier_restartless-0.7.0-fx.xpi'
$checksum    = '56AA88AF5A2046CC29216575141B794E743DBE72046A1A9756FB7C952B46C4B0'
$extensionID = "{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"

if(test-path 'hklm:\SOFTWARE\Mozilla\Firefox\TaskBarIDs'){
	$installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}
if(test-path 'hklm:\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs'){
	$installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}

$browserFolder = Join-Path $installDir "browser"
$extensionsFolder = Join-Path $browserFolder "extensions"
$extFolder = Join-Path $extensionsFolder "$extensionID"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extFolder
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256' 
}

if (!(Test-Path $extFolder)) {
	New-Item -Force -ItemType directory -Path $extFolder 
	Install-ChocolateyZipPackage @packageArgs
}
else {
	Write-Host "$packageName already exists"
}
