$ErrorActionPreference = 'Stop'
$packageName= 'winflector-client'
$softwareName = 'Windows Driver Package - Era software*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.winflector.com/store/free-version/index/id/249' 
$checksum   = '5FD4775ABDF69BA16E981EEA69E9217E45F74C3DB292632E03C437E8DF2A983B'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes= @(0, 3010, 1641)

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
