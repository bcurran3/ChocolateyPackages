# https://www.fosshub.com/IrfanView.html/irfanview_plugins_442_setup.exe
$packageName    = 'irfanviewplugins'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\irfanview_plugins_442_setup.exe"
$checksum       = '18494995dcad42c7227faebdb7b8c09935ff3ad7a57effc5ca3cf16ea3972311'
$url64          = "$toolsDir\irfanview_plugins_x64_442_setup.exe"
$checksum64     = '35cbcede45773e324d203fb7d72789570e9460ba4ef50d282084ab00b2332f21'
$validExitCodes = @(0)
$silentArgs     = "/silent"

					  
$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
  Checksum64    = $checksum64
  ChecksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  

Remove-Item $url 
Remove-Item $url64							  