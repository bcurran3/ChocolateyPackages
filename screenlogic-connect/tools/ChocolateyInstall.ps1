$packageName    = 'screenlogic-connect'
$installerType  = 'exe'
$url            = 'https://pentairpool.com/~/media/websites/pool/software/screenlogic/build-5-2-736/step%202%20-%20install%20screenlogic%20connect%20software%20736.exe'
$checksum       = 'A66F3C86BACF0F813976F12D8E4C38FE21D2A26A935D4C92E1FF4F5E8B6A12F3'
$silentArgs     = '/quiet'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'Pentair ScreenLogic'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

