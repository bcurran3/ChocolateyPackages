$packageName   = 'expandrive' 
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v5-4-4_published_2017-01-18_at_21_45_42/ExpanDriveInstaller.msi' 
$checksum      = '8C05399E922D7FE2505856E38838C3D3B78D5BF7840B44A4EEADB608849FBAAB'
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

