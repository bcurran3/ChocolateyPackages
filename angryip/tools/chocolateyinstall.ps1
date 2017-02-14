$packageName   = 'angryip'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'https://github.com/angryziber/ipscan/releases/download/3.5.1/ipscan-3.5.1-setup.exe'
$checksum      = '362E60A32DC864D5660BB7A9CAAE50B068BDD81924469BB014AF395EBEEF9A9E'
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

