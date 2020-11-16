$ErrorActionPreference = 'Stop'
$packageName    = 'ntlite-free'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://downloads.ntlite.com/files/NTLite_setup_x86.exe' 
$checksum       = '8745DA95A0967107ADD403FF41BADFD1E43D495FA45ABCA8C8CABBFEA54BE434'
$url64          = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe' 
$checksum64     = '507F40BC39F0658142C4171ADD3D7864B9EE557326582FB36E88DB60A49F48AD'

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
