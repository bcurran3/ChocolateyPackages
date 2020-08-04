$ErrorActionPreference = 'Stop'
$packageName    = 'intel-processor-identification-utility'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/28539/a08/Intel(R)%20Processor%20Identification%20Utility.exe'
$checksum       = 'F87593F4E2EC5C703668881C91A2CD175901C490D17A22AE8414D609593D4719'

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
