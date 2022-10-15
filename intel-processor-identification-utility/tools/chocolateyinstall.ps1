$ErrorActionPreference = 'Stop'
$packageName    = 'intel-processor-identification-utility'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/28539/Intel%20Processor%20Identification%20Utility.exe'
$checksum       = 'FFA943557F13D717B286D5CCB6797654E49A889719CEF2ED5845EB76953EB5B9'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /norestart'
  softwareName   = 'Intel(R) Processor Identification Utility'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
