$ErrorActionPreference = 'Stop'
$packageName = 'google-backup-and-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.google.com/drive/gsync_enterprise.msi'
$checksum    = 'FB5A3205F4D5D5243FDB16104C707521DC1BD8C36195575BAB61A64085DA8F67'
$url64       = 'https://dl.google.com/drive/gsync_enterprise64.msi'
$checksum64  = '8C723ED84CF0B8EF69B041943D742F84C59710F524AF76919EE279ABDA795BB8'

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
