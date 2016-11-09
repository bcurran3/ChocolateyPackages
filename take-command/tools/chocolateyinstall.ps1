$ErrorActionPreference = 'Stop'
$packageName= 'take-command'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://jpsoft.com/downloads/v20/tcmd.exe'
$checksum   = 'D0ED94DB96C65EB726ABB5A3BE31B10817755326198921EE2DE6A6F1B582B964'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  checksum      = $checksum 
  checksumType  = 'sha256'
  softwareName  = 'Take Command*'
  silentArgs   = '/PASSIVE'
  validExitCodes= @(0) 
}

Install-ChocolateyPackage @packageArgs 
