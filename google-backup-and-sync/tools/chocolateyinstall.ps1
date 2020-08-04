$ErrorActionPreference = 'Stop'
$packageName = 'google-backup-and-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.google.com/drive/gsync_enterprise.msi'
$checksum    = 'ECC306B50E37F90856AE041C84705E2C582FB5C634A614F2BEEAB7ABE97BDC00'
$url64       = 'https://dl.google.com/drive/gsync_enterprise64.msi'
$checksum64  = 'A3804311E55503EC75AA5FC76489C7C164DDA4E8C9BC61BA428D3CF266CC4C7F'

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
