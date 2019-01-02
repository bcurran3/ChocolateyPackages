$packageName = 'wot-firefox'
$extensionID = '{a0d7ccb3-214d-498b-b4aa-0e8fda9a7bf7}'
$url         = 'https://addons.mozilla.org/firefox/downloads/file/998298/web_of_trust_mywotwot_website_reputation_rating-20180622.0wot-an+fx.xpi'
$checksum    = '10EC6713F08A45E5C99D9350D72217025B1247BBEE58AC3CDDE9800661D42AB6'

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
