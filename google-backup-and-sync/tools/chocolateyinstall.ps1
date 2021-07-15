$ErrorActionPreference = 'Stop'
$packageName = 'google-backup-and-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.google.com/drive/gsync_enterprise.msi'
$checksum32  = '1215fbcff3f68ddb3788c4a28a0b8a0b6bb5c2aa272fdc90827ba4e2d80122f8'
$url64       = 'https://dl.google.com/drive/gsync_enterprise64.msi'
$checksum64  = '85acdefb269b1627ca2340006be5d8a6ec19f9946a80375600d40bda26db98b4'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  url64          = $url64
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /norestart'
  softwareName   = 'Backup and Sync from Google'
  checksum       = $checksum32
  checksumType   = 'sha256'
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs  
