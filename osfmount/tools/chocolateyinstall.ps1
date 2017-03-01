$ErrorActionPreference = 'Stop'
$packageName= 'osfmount' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.osforensics.com/downloads/osfmount.exe'
$checksum   = 'EBA56C38791DFA34CDAD7632B27FA2E852B5637ACD93F02C04BA8DCBADDB0A36'
$url64      = 'http://www.osforensics.com/downloads/osfmount_x64.exe'
$checksum64 = 'B41134466D1D059FCD02F2A8AF82543A0332994FF798DC5187827D6F61C2ACAC'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = $silentArgs
  softwareName  = 'OSFMount*' 
  }
Install-ChocolateyPackage @packageArgs
