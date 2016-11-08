$packageName = 'video-card-stability-test'
$installerType = 'exe'
$url = 'http://freestone-group.com/download/VideoCardStabilityTestSetup.exe'
$silentArgs = '/S' 
$validExitCodes = @(0) 

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  softwareName  = "Video Card Stability Test*"
  checksum      = '0CBBCD3A869626760F021BD534BD0BFFD1930EEE050BA08D1399BE5570BA17D9'
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs



						  
						  
						  
						  
