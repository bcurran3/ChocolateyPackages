$packageName   = 'expandrive' 
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v5-4-2_published_2016-11-22_at_17_05_41/ExpanDriveInstaller.msi' 
$checksum      = 'EE321782F1E27AF1C852BF61D044384824E0AAA6EEE999D9DE4386E811101B6D'
$installerType = 'MSI'
$silentArgs = '/quiet /qn /norestart'
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

