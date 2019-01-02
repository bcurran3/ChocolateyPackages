$packageName    = 'gsuite-migration-outlook'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://dl.google.com/tag/s/appguid%3D%7B7DF3B6EE-9890-4307-BDE5-E1F3FCB09771%7D%26iid%3D%7BF8313931-0A96-BEDC-57C8-A94587ACC093%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DG%2520Suite%2520Migration%2520for%2520Microsoft%2520Outlook%25C2%25AE%26needsadmin%3Dtrue/outlookmigration/OutlookMigrationSetup.exe' 
$checksum       = '062F385A7AF096A774A09B0892F3AC7BB1A562A399514A3BEE620B6B77CE2EA2'
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\GSMMOInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE' 
  url            = $url
  softwareName   = 'Google Apps Migration for Microsoft Outlook*' 
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = ''
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs 
  
