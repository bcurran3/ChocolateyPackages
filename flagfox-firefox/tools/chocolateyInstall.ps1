$packageName = 'flagfox-firefox'
$url         = 'https://addons.mozilla.org/firefox/downloads/file/1175010/flagfox-6.1.9-fx.xpi'
$checksum    = 'AB33528A7F58C0C108094EC2D5828554495117B0072C84573334A029BCCCF4AC'
$extensionID = "{1018e4d6-728f-4b20-ad56-37578a4de76b}"

if(test-path 'hklm:\SOFTWARE\Mozilla\Firefox\TaskBarIDs'){
	$installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}
if(test-path 'hklm:\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs'){
	$installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}

$browserFolder = Join-Path $installDir "browser"
$extensionsFolder = Join-Path $browserFolder "extensions"
$extFolder = Join-Path $extensionsFolder "$extensionID"

Write-host DEBUG: $extFolder

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
