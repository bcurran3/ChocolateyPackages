$ErrorActionPreference = 'Stop'
$packageName    = 'intel-processor-identification-utility'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/28539/a08/Intel(R)%20Processor%20Identification%20Utility.exe'
$checksum       = '7D5F3256F8DE62019575CA99C6315C79B26F4E0C8C45C7298278BF9E4A78EE07'

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
