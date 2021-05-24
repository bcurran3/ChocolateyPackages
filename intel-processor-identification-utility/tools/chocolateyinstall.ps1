$ErrorActionPreference = 'Stop'
$packageName    = 'intel-processor-identification-utility'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/28539/a08/Intel(R)%20Processor%20Identification%20Utility.exe'
$checksum       = '320EB120118B2F690728862983DFB6222012E9AB2FEB436E809AE23D92EF7806'

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
