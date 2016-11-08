$packageName = 'https-everywhere-firefox'
$url = 'https://addons.mozilla.org/firefox/downloads/latest/229918/addon-229918-latest.xpi'
$extensionID = "https-everywhere@eff.org"

if(test-path 'hklm:\SOFTWARE\Mozilla\Firefox\TaskBarIDs'){
	$installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}
if(test-path 'hklm:\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs'){
	$installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}

$browserFolder = Join-Path $installDir "browser"
$extensionsFolder = Join-Path $browserFolder "extensions"

$extFolder = Join-Path $extensionsFolder "$extensionID"
if (!(Test-Path $extFolder)) {
	New-Item -Force -ItemType directory -Path $extFolder 
	
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extFolder 
  fileType      = 'ZIP' 
  url           = $url
  checksum      = 'E8E1E22F1E48E4F63F81A0E55CD9490003CACCCB5724F0AE1225AC57CAD67F8A'
  checksumType  = 'sha256' 	
}
	
	Install-ChocolateyZipPackage @packageArgs
}
else {
	Write-Host "$packageName already exists"
}
