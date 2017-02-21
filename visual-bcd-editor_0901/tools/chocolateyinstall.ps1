$packageName   = 'visual-bcd-editor'
$installerType = 'MSI'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.boyans.net/VisualBcd5/VisualBcd_0.9.0.1.msi' 
$checksum      = 'B0A4AE5697F042B0E46FF9E42E7643C711106D2D3F246757F9CD29751C630004'
$silentArgs    = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Visual BCD'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
