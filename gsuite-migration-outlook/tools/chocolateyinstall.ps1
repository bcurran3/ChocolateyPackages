$ErrorActionPreference = 'Stop'
$packageName   = 'gsuite-migration-outlook'
$installerType = 'EXE'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://dl.google.com/tag/s/appguid%3D%7B7DF3B6EE-9890-4307-BDE5-E1F3FCB09771%7D%26iid%3D%7B763A8E04-9BD6-AD60-8318-E6C4E060C50F%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Apps%2520Migration%2520for%2520Microsoft%2520Outlook%25C2%25AE%26needsadmin%3Dtrue/outlookmigration/OutlookMigrationSetup.exe' 
$checksum      = '15D08131DA54393BE4F875BE1B1ED159500A0F5B6B4DB45027C78D8C99358D32'
$silentArgs    = ''
$validExitCodes= @(0)
$ahkExe        = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "GSMMOInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'Google Apps Migration for Microsoft Outlook*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs 
  
