$packageName = 'https-everywhere-firefox'
$url         = 'https://addons.mozilla.org/firefox/downloads/latest/https-everywhere/addon-229918-latest.xpi'
$checksum    = '1A0F30E3BBC26720B8C99317C9DF9955F286CF944B0D3B2F9F6AE1C3C572F145'
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
  checksum      = $checksum
  checksumType  = 'sha256' 	
}
	
	Install-ChocolateyZipPackage @packageArgs
}
else {
	Write-Host "$packageName already exists"
}
