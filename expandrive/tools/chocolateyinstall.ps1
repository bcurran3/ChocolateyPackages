$packageName   = 'expandrive' 
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v6-1-0_published_2017-09-25_at_14_30_36/ExpanDrive_Setup_6.1.0.exe' 
$checksum      = '693BECFB56E0C8CAE9EDCF5C7671EE3B2D647DAF5237A483EAB7EDC45A69EF4A'
$installerType = 'EXE'
$silentArgs    = ''
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Expandrive*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  

