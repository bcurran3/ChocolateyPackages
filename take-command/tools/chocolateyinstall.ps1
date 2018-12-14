$ErrorActionPreference = 'Stop'
$packageName = 'take-command'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://jpsoft.com/downloads/v24/tcmd.exe'
$checksum    = '78B80A7F6D9B29DD208673F489A145DF7002CEBC2E12C232310FAC6C57CB7005'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  checksum       = $checksum 
  checksumType   = 'sha256'
  softwareName   = 'Take Command*'
  silentArgs     = '/PASSIVE'
  validExitCodes = @(0) 
}

Install-ChocolateyPackage @packageArgs 
