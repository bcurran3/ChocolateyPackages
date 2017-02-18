$packageName    = 'edgedeflector'
$installerType  = 'exe'
$url            = 'https://github.com/da2x/EdgeDeflector/releases/download/v1.0.1.0/EdgeDeflector.exe' 
$checksum       = '260477DE37DFD2CC94B09DB411943E6626EA99B06F1DE28136ABC26B6EC76DD9'
$silentArgs     = ''
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
