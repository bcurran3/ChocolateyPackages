$packageName   = 'expandrive' 
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v6-0-8_published_2017-07-07_at_15_20_21/ExpanDrive_Setup_6.0.8.exe' 
$checksum      = 'D4ABD52A8E8A31B84D30C6E24425412AE8D53CBE181A030EA613A1E541D58410'
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

