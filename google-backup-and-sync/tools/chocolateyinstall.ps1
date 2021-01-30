$ErrorActionPreference = 'Stop'
$packageName = 'google-backup-and-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.google.com/drive/gsync_enterprise.msi'
$checksum32  = '5f8b34c59f5013f9bc3fb9df3ed77e02bdd28090ebabb0db53ba658a3f56bbc0'
$url64       = 'https://dl.google.com/drive/gsync_enterprise64.msi'
$checksum64  = '53b6b61b3250c5fb1df5dcae0e7de0b82faefa0cf09ee4b9e87ecad59a71ece3'

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
