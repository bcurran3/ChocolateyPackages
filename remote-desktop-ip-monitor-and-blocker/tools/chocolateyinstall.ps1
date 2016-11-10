$ErrorActionPreference = 'Stop'
$packageName= 'remote-desktop-ip-monitor-and-blocker'
$softwareName = 'Tweaking.com - Remote Desktop IP Monitor*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.tweaking.com/files/setups/tweaking.com_remote_desktop_ip_monitor_blocker_setup.exe' 
$checksum   = 'C727FA841D6D6A262C4396285BE63361222EBD35A4A15D2FAB410FDD98D069A8'
$silentArgs = '/S'
$validExitCodes= @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
