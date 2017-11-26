$packageName   = 'expandrive' 
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v6-1-6_published_2017-11-22_at_20_59_12/ExpanDrive_Setup_6.1.6.exe' 
$checksum      = 'AC341980EB7A577A65B74245A0BF4341EC6211BDD9DB533CC0A558C3EEC2D8A1'
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

