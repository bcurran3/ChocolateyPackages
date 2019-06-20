$ErrorActionPreference = 'Stop'
$packageName = 'google-backup-and-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.google.com/drive/gsync_enterprise.msi'
$checksum    = '5584C9B88DC95EE2D77182F131A51CB5E7662B31228DA23CFE6B79F69F793809'
$url64       = 'https://dl.google.com/drive/gsync_enterprise64.msi'
$checksum64  = '0B7CD52E6A0216AA7640E6AAAA1E4FD81DB79E6A831FC2E67297975AA5EADB69'

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
