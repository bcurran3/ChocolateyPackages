# https://ea.im/Doc.aspx?D=196&dn=AllWemo_setup_3_37.zip
$packageName    = 'allwemo'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\AllWemo.msi" 
$checksum       = 'D6A184E53DC9FF035503154A0173B928DC94B4067EFDD7FD2BE2F8B56BE25638'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'AllWemo*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  