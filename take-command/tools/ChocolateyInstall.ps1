$ErrorActionPreference = 'Stop'
$packageName = 'take-command'
$global:packageMaintainer = 'BCURRAN3'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://jpsoft.com/downloads/v23/tcmd.exe'
$checksum    = '5BBEE4111F11A656E57FD18C2B122977BE0458E0A09FBCFD54D83695A5F58BB1'


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

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs 
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."

