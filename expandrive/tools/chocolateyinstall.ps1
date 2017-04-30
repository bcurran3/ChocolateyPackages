$packageName   = 'expandrive' 
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v5-4-6_published_2017-04-25_at_18_34_01/ExpanDriveInstaller.msi' 
$checksum      = 'DFE6292CE4458874A5CCB2B779031EDC2ABDFB59FE755F26740B7065C219E625'
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

