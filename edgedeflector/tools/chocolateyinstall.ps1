$packageName    = 'edgedeflector'
$installerType  = 'exe'
$url            = 'https://github.com/da2x/EdgeDeflector/releases/download/v1.0.1.0/EdgeDeflector_install.exe' 
$checksum       = 'BF01F9051FB6B233997370C97FA70F4D406D31154EE90EC54EEE9B1C803219EB'
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
  
