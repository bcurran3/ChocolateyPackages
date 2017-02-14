$ErrorActionPreference = 'Stop'
$packageName= 'take-command'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://jpsoft.com/downloads/v20/tcmd.exe'
$checksum   = '70FC72B7709821ABD1B3F810D8E2749BDE1B71A7E787952DB2F9297818FC8B30'


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
