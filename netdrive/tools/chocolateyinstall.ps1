$packageName    = 'netdrive'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://files.netdrive.net/build/NetDrive2_Setup_2_6_13_938.exe' 
$checksum       = 'F4C24294EBDB7C34FC7BD43220026F35DEC9E2AC20B8AD46141D64FE4499B8C1'
$silentArgs     = "/S"
$validExitCodes = @(0,1223)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'NetDrive2*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  