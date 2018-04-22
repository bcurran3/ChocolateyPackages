$packageName    = 'intel-processor-identification-utility'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/7838/eng/pidenu47.msi' 
$checksum       = '89883607CDFBF447FC9AE74BEBAAB57C20EF8101620D59791EBEE256B467172C'
$silentArgs     = '/quiet /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Intel(R) Processor Identification Utility'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
