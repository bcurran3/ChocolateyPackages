$ErrorActionPreference = 'Stop'
$packageName    = 'ost2' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://d.4team.biz/files/ost2_setup.exe'
$checksum       = '0392A3D3AA6611A6638908CBB7F430C6D077718B1FC1024D093C2D4ACD7E76FA'
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
