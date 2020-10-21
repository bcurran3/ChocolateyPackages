$ErrorActionPreference = 'Stop'
$packageName = 'google-backup-and-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.google.com/drive/gsync_enterprise.msi'
$checksum32  = '6775e230b991ff3fe79a029a7ff8aa841611f1662c58401ead0f42f882c6dabf'
$url64       = 'https://dl.google.com/drive/gsync_enterprise64.msi'
$checksum64  = '36826b3cff37a455199599c4067d67cbc8f2d40ebc8b84a404a3168a943598fe'

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
