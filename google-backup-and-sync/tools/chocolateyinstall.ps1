$packageName = 'google-backup-and-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.google.com/drive/gsync_enterprise.msi'
$checksum    = '5536CF0A1BBDE156A954E008DCB5C9C6DFACB450BF22026158FA5EE180876E81'
$url64       = 'https://dl.google.com/drive/gsync_enterprise64.msi'
$checksum64  = '628ADDF2476C4BB77C2F46773F69884A0207448683FCF6D2D52D58AE4F777D01'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  url64          = $url64
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /norestart'
  softwareName   = 'Backup and Sync from Google'
  checksum       = $checksum
  checksumType   = 'sha256'
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs  
  
