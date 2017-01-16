$ErrorActionPreference = 'Stop'
$packageName= 'amazon-music'
$softwareName = 'Amazon Music'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://images-na.ssl-images-amazon.com/images/G/01/digital/music/morpho/installers/20170111/083554d100/AmazonMusicInstaller.exe' 
$checksum   = 'E7154D87AD55E2DB4EBC0B134D7E028E9E547F6B1669DD0A69076335DDD7ACD7'
$silentArgs = '--mode unattended'
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
