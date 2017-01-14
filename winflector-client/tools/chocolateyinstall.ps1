$ErrorActionPreference = 'Stop'
$packageName= 'winflector-client'
$softwareName = 'Windows Driver Package - Era software*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.winflector.com/store/free-version/index/id/265' 
$checksum   = 'F693E561B1188CB2C3C0C08C2F081B2BC61B24EB61B4E1C0FE1DA8C06F90D877'
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
