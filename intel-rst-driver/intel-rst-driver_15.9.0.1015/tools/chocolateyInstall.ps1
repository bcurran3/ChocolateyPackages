$packageName = 'intel-rst-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloadmirror.intel.com/27400/eng/SetupRST.exe'
$checksum    = '7B2FFDACE995FB0CF755E8AFEDA24A8C09ADE9AC8011489CCC002F70B9739839'
$silentArgs  = '-s' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = $silentArgs
  softwareName  = 'Intel(R) Rapid Storage Technology' 
  }

Install-ChocolateyPackage @packageArgs

