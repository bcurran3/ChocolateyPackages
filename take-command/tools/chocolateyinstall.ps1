$ErrorActionPreference = 'Stop'
$packageName= 'take-command'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://jpsoft.com/downloads/v20/tcmd.exe'
$checksum   = '4DDB891DDFEE474D4FCA94F292A542997995568D43F31F3F90B7623044773909'


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
