$packageName    = 'google-backup-and-sync' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/tag/s/appguid%3D%7B3C122445-AECE-4309-90B7-85A6AEF42AC0%7D%26iid%3D%7B9648D435-67BA-D2A7-54D2-1E0B5656BF03%7D%26ap%3Duploader%26appname%3DBackup%2520and%2520Sync%26needsadmin%3Dtrue/drive/installbackupandsync.exe'
$checksum       = '60D56C4BBB7D5C86DC631E03A21B3F5FB97503ECA094B0F7D2776511D20E56BD'
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "GBASInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs    = '' 
  softwareName  = 'Backup and Sync from Google'
  checksum      = $checksum
  checksumType  = 'sha256'  
  validExitCodes = $validExitCodes
  }
  
Install-ChocolateyPackage @packageArgs
