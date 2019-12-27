$ErrorActionPreference = 'Stop'
$packageName = 'dell-update' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.dell.com/FOLDER05312735M/5/Dell-Update-Application_4985D_WIN_3.0.1_A00_01.EXE'
$checksum    = 'C9E7F22374FF2EB49329B91E0E0EB187FB5DC68147F02B10F07313C3D7F84E6A'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/s /l="c:\test\DUPlog.txt"'
  validExitCodes= @(0,2)
  softwareName  = 'Dell Update for Windows 10' 
}

Install-ChocolateyPackage @packageArgs
