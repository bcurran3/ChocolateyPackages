$ErrorActionPreference = 'Stop'
$packageName    = 'intel-processor-identification-utility'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/28539/Intel%20Processor%20Identification%20Utility.exe' # url does not change
$checksum       = 'F46830E9F41421CE2AE531F2FCC710E297691761C4BC4CC41ACD0A24CB10F8F5'

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
