$ErrorActionPreference = 'Stop'
$packageName    = 'winhue'
$installerType  = 'EXE'
$url            = 'https://github.com/Hyrules/WinHue/releases/download/3.0.4334.0/WinHue.3.0.4334.0.Setup.exe' 
$checksum       = '01DBC8735A8B854258CEEFA1229D27BD46901669FE0857B114E8090FC56B6A2A'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
  softwareName  = 'WinHue*'
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyPackage @packageArgs
  