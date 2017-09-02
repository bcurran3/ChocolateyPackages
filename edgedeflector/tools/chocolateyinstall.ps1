$packageName    = 'edgedeflector'
$installerType  = 'exe'
$url            = 'https://github.com/da2x/EdgeDeflector/releases/download/v1.1.1.0/EdgeDeflector_install.exe' 
$checksum       = '2C12A85769C68468721A9A096DDE95A065DEDAC5266BEF22A65FE5721369FC11'
$silentArgs     = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'EdgeDeflector'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
