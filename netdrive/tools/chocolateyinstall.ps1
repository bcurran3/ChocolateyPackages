$packageName= 'netdrive'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://files.netdrive.net/build/NetDrive2_Setup_2_6_12_928.exe' 
$silentArgs = "/S"
$validExitCodes= @(0,1223)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'NetDrive2*'
  checksum      = 'C8EB7D16413DFE189697C05B0DD1A0D8F1DB5D9634A54B4FEFBA2FDFEE0AD125'
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  