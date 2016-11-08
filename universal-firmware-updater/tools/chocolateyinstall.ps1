$ErrorActionPreference = 'Stop'
$packageName= 'universal-firmware-updater' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.wdc.com/fwupdater/Win/WDFirmwareUpdater.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = 'E3E337B8B9354D1B5D506C4EC14EE144246537713D2F9EC040307D85014CDF26'
  checksumType  = 'sha256' 
  checksum64    = 'E3E337B8B9354D1B5D506C4EC14EE144246537713D2F9EC040307D85014CDF26'
  checksumType64= 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\WD Firmware Updater.lnk" -targetPath "$toolsDir\WDFirmwareUpdater.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\WD Firmware Updater.lnk" -targetPath "$toolsDir\WDFirmwareUpdater.exe" -WorkingDirectory "$toolsDir"