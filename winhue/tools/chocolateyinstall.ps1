$ErrorActionPreference = 'Stop'
$packageName    = 'winhue'
$installerType  = 'EXE'
$url            = 'https://github.com/Hyrules/WinHue3/releases/download/RC5_2/WinHue.3.0.1422.0.Setup.exe' 
$checksum       = 'BECF755CBBF6719008FF8E0ABAF77BA845B3A66B2A389BDE6201FF5E51E6E439'
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
  