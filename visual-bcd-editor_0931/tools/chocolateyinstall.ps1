$packageName   = 'visual-bcd-editor'
$installerType = 'MSI'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.boyans.net/VisualBcd5/VisualBcd_0.9.3.1.msi' 
$checksum      = 'AEE210997A3B9D19277FAD3EFF5B4641482A4F9C39D519266FB49FADA498A4E0'
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
  
