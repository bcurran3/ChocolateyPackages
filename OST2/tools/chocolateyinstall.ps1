$ErrorActionPreference = 'Stop'
$packageName    = 'ost2' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://d.4team.biz/files/ost2_setup.exe'
$checksum       = 'BCCC9433994CC183F2775CBC88666541C30B7B29442744B73C1B2D9CDB7B503A'
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
