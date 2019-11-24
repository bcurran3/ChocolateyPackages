$ErrorActionPreference = 'Stop'
$packageName = 'google-backup-and-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.google.com/drive/gsync_enterprise.msi'
$checksum    = 'FAAC9CE566EE2B98AB2B99240DFB55C2C07FF88679E8060EFE4305F792CD7EA6'
$url64       = 'https://dl.google.com/drive/gsync_enterprise64.msi'
$checksum64  = '0B6BE68E01CEC1F1081A7FFAA3AA23EEC8DEA25BE6A686E594C9912852F17FAA'

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
