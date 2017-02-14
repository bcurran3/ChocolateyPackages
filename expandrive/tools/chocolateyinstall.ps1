$packageName   = 'expandrive' 
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v5-4-5_published_2017-02-03_at_21_38_25/ExpanDriveInstaller.msi' 
$checksum      = '1A80A948D9E3D1E9683BC179E95A07EE67908E5FEA1D65EB4770B2A59233668A'
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

