$ErrorActionPreference = 'Stop'
$packageName = 'google-backup-and-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.google.com/drive/gsync_enterprise.msi'
$checksum    = 'A3994C44944B4B4FE8D8B89903DA1829184B7CEB8D284652C23FA668E75D2ED2'
$url64       = 'https://dl.google.com/drive/gsync_enterprise64.msi'
$checksum64  = '1C8F6DC4DE56D47857529F36532446C51CBA6931040C6A1FC1E631CF1F45C136'

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
