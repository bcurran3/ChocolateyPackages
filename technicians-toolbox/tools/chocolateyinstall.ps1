$ErrorActionPreference = 'Stop'
$packageName= 'technicians-toolbox'
$softwareName = 'Tweaking.com - Technicians Toolbox*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.tweaking.com/files/setups/tweaking.com_technicians_toolbox_setup.exe' 
$checksum   = 'B9D271BCC7E15B8EF0D7BEAC22FB437431B0E98EF2CA5AFD24E4E916FB851B42'
$silentArgs = '/S'
$validExitCodes= @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
