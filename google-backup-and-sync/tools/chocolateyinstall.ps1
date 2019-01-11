$packageName = 'google-backup-and-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.google.com/drive/gsync_enterprise.msi'
$checksum    = 'FA39A76EE91736EC2056B1F0F17390F5382D865F3FDE170C9D971A7617F7B428'
$url64       = 'https://dl.google.com/drive/gsync_enterprise64.msi'
$checksum64  = '48F54D68D686F8E9CB6607E92EAAFED815F05D424BFFCD94EC53429EE9CF49CB'

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
