$ErrorActionPreference = 'Stop'
$packageName= 'take-command'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://jpsoft.com/downloads/v20/tcmd.exe'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  checksum      = 'FE9D14B2FE6732A1E909986F1EFABDED5615CA4769849D63CA61F4AF1B4F4318'
  checksumType  = 'sha256'
  softwareName  = 'Take Command*'
  silentArgs   = '/PASSIVE'
  validExitCodes= @(0) 
}

Install-ChocolateyPackage @packageArgs 
