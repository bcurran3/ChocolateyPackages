$ErrorActionPreference = 'Stop'
$packageName = 'take-command'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://jpsoft.com/downloads/v22/tcmd.exe'
$checksum    = 'FC1AB028CCBFDA7231E1452BF7247DBB25E86543541F135548628351DF790E8F'


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
