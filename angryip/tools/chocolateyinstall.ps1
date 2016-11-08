$packageName   = 'angryip'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'https://github.com/angryziber/ipscan/releases/download/3.4.2/ipscan-3.4.2-setup.exe'
$silentArgs    = '/S'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'Angry IP Scanner*' 
  checksum      = '5273CD88FCBBAFE3921DBB88F330A09B4B00C6BBAD7D4BC0BF897558A24BB5EB'
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs

