$packageName   = 'angryip'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'https://github.com/angryziber/ipscan/releases/download/3.5.2/ipscan-3.5.2-setup.exe'
$checksum      = '1222D5AC68AB90DFCB14E3C2E2258D695DE12B27D3AADBBD94AA85A3A85D4701'
$silentArgs    = '/S'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'Angry IP Scanner*' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs

