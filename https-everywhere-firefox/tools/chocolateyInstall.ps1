$packageName = 'https-everywhere-firefox'
$url         = 'https://addons.cdn.mozilla.net/user-media/addons/229918/https_everywhere-5.2.9-an+fx+sm+tb.xpi'
$checksum    = '770668C7F296D6C0BDE3320354854781FC5E871FEDA345D2B22005EE33EACDAF'
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
