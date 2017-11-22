$ErrorActionPreference = 'Stop'
$packageName= 'universal-firmware-updater' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.wdc.com/fwupdater/Win/WDFirmwareUpdater.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = 'EAFFA980FEB866D51D8851E980037515DB72F29A4D2FAEE517181D03DA4F5E96'
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\WD Firmware Updater.lnk" -targetPath "$toolsDir\WDFirmwareUpdater.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\WD Firmware Updater.lnk" -targetPath "$toolsDir\WDFirmwareUpdater.exe" -WorkingDirectory "$toolsDir"