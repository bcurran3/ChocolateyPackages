$ErrorActionPreference = 'Stop'
$packageName    = 'ntlite-free'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://downloads.ntlite.com/files/NTLite_setup_x86.exe' 
$checksum       = '6C4B46B6A54A2EAC77C4E81A1DC20E1534F57B19BB9D1DC7931E5451995A1613'
$url64          = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe' 
$checksum64     = '72E6C8B5A358E2BE21A2F44E12B6F7AC47F469E3E12B17775C6F667B05A36B65'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  url64bit       = $url64
  validExitCodes = @(0)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'NTLite*'
  checksum       = $checksum 
  checksumType   = 'sha256' 
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
