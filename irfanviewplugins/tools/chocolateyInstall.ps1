# https://www.fosshub.com/IrfanView.html/irfanview_plugins_442_setup.exe
$packageName    = 'irfanviewplugins'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\irfanview_plugins_444_setup.exe"
$checksum       = '2802CA82B660C5FCF8948F41671710F71C4BA4E648581BC4F3A87A5ED5F05364'
$url64          = "$toolsDir\irfanview_plugins_x64_444_setup.exe"
$checksum64     = 'D7BDBBC59233FDC70FDDAC3B3DAE79669FEA7FEFA58C97D4B2131426B4C7C355'
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