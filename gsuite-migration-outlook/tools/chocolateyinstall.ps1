$packageName    = 'gsuite-migration-outlook'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/tag/s/appguid%3D%7B7DF3B6EE-9890-4307-BDE5-E1F3FCB09771%7D%26iid%3D%7BECF95E4D-805F-E6BA-1ECF-81E05876B2A6%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DG%2520Suite%2520Migration%2520for%2520Microsoft%2520Outlook%25C2%25AE%26needsadmin%3Dtrue/outlookmigration/OutlookMigrationSetup.exe' 
$checksum       = '6846C23A6F0290EE676692EB0378DC2AFCE7B24962C2671EAA7F3AD620E697E7'
$silentArgs     = ''
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "GSMMOInstall.ahk"

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
  
