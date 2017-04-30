$ErrorActionPreference = 'Stop'
$packageName    = 'winhue'
$installerType  = 'EXE'
$url            = 'https://github.com/Hyrules/WinHue3/releases/download/rc1/WinHue.3.RC.1.Setup.exe' 
$checksum       = 'F9427BEB51164A8508D1F4EBEBF983C6C4F5E190A84AB18932AD159EE069CF72'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = $silentArgs  
  validExitCodes= $validExitCodes
  softwareName  = 'WinHue*'
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyPackage @packageArgs
  