$packageName    = 'netdrive'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://files.netdrive.net/build/NetDrive2_Setup_2_6_17_965.exe' 
$checksum       = '9EC7FB0E5169D4EFD62CBEB7562BD723469CEC6790F89F7AF08859EFB57D89C6'
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