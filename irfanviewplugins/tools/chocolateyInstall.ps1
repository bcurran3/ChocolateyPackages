$packageName = 'irfanviewplugins'
$installerType = 'exe'
$urlArray = @('https://www.fosshub.com/IrfanView.html/irfanview_plugins_442_setup.exe','https://www.fosshub.com/IrfanView.html/irfanview_plugins_x64_442_setup.exe')
$url = $urlArray[0]
$checksum = '18494995dcad42c7227faebdb7b8c09935ff3ad7a57effc5ca3cf16ea3972311'
$checksumType = 'sha256'
$url64 = $urlArray[1]
$checksum64 = '35cbcede45773e324d203fb7d72789570e9460ba4ef50d282084ab00b2332f21'
$checksumType64 = 'sha256'
$validExitCodes = @(0)
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$silentArgs = "/silent"

if (!(Get-Command Get-UrlFromFosshub -ErrorAction SilentlyContinue)) {
  Import-Module "$($toolsDir)\Get-UrlFromFosshub.ps1"
}
$url = Get-UrlFromFosshub $url
$url64 = Get-UrlFromFosshub $url64
						  
$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = ''
  checksum      = $checksum
  checksumType  = $checksumType
  Checksum64    = $checksum64
  ChecksumType64= $checksumType64
}

Install-ChocolateyPackage @packageArgs  						  