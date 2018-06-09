$ErrorActionPreference = 'Stop'
$packageName    = 'winhue'
$installerType  = 'EXE'
$url            = 'https://github.com/Hyrules/WinHue3/releases/download/RC5_3/WinHue.3.0.2128.0.Setup.exe' 
$checksum       = '1B17E738BEE241E336CF21EAFBD94013E9D1089B1BB6BD42550AF1E65C26A171'
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
  