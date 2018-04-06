$ErrorActionPreference = 'Stop'
$packageName    = 'ost2' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://d.4team.biz/files/ost2_setup.exe'
$checksum       = 'E201D1D272F35EC3257250AB0520AAD0B7F61F4C4A0905D91869174CCBA54C06'
$validExitCodes = @(0,2)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "OST2install.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = '/S'
  validExitCodes=$validExitCodes
  softwareName  = 'OST2*' 
  }
  
Install-ChocolateyPackage @packageArgs
