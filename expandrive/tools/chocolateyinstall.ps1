$packageName   = 'expandrive' 
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v5-5-3_published_2017-06-20_at_20_07_15/ExpanDriveInstaller.msi' 
$checksum      = '2F2A465485A03476D4BCA1FB997E177BB20B3D2005EAC95EAC717A5FA1B045BB'
$installerType = 'MSI'
$silentArgs    = '/quiet /qn /norestart'
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

