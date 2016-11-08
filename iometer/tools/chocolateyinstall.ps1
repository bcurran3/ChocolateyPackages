$ErrorActionPreference = 'Stop'
$packageName    = 'iometer' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://downloads.sourceforge.net/project/iometer/iometer-stable/1.1.0/iometer-1.1.0-win32.i386-setup.exe'
$silentArgs     = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  checksum      = '814190A44A5D62E544CBB6D6A5DDB81A7E02B0A5E8043040EB82A6A6992C2DAF'
  checksumType  = 'sha256'   
}

Install-ChocolateyPackage @packageArgs
