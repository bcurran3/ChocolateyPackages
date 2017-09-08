$packageName   = 'expandrive' 
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v6-0-15_published_2017-09-07_at_21_00_09/ExpanDrive_Setup_6.0.15.exe' 
$checksum      = '79F363F1F99CA6E71E1CE25B84C266CFE08A6F2B601D52560FB72A14B94352BE'
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

