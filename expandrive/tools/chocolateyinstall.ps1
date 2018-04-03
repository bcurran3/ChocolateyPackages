$packageName   = 'expandrive' 
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v6-1-15_published_2018-03-30_at_13_53_48/ExpanDrive_Setup_6.1.15.exe' 
$checksum      = '1E8A157BAEF995C81BB551778544D854214891FBC8B3AE395B854F38F6990D49'
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

