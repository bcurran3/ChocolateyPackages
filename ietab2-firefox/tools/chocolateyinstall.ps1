$packageName = 'ietab2-firefox'
$extensionID = "{1BC9BA34-1EED-42ca-A505-6D2F1A935BBB}"
$Title = 'IE Tab V2  (Enhanced IE Tab)'
$AddOnID = 92382
$url = 'https://addons.mozilla.org/firefox/downloads/latest/92382/platform:5/addon-92382-latest.xpi'


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
  checksum      = 'B6F27DBC3897D1DE6A0E8D3E58EE0AF0EC1D8FE30285B41F68E2B3CE9E923221'
  checksumType  = 'sha256' 
}

if (!(Test-Path $extFolder)) {
	New-Item -Force -ItemType directory -Path $extFolder 
	Install-ChocolateyZipPackage @packageArgs
}
else {
	Write-Host "$packageName already exists"
}
