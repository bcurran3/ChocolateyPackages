$packageName   = 'expandrive' 
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v6-1-9_published_2017-12-21_at_20_00_22/ExpanDrive_Setup_6.1.9.exe' 
$checksum      = '88DF0BC8C75BC46087693D74AD6DF75CF36242ABBBE7C436725F411B642C5B28'
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

