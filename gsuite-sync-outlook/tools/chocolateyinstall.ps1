﻿$ErrorActionPreference = 'Stop'
$packageName    = 'gsuite-sync-outlook'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/tag/s/appguid%3D%7BBEBCAD10-F1BC-4F92-B4A7-9E2545C809ED%7D%26iid%3D%7BE094FE53-B836-8E02-5B87-DA45F95AD839%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DG%2520Suite%2520Sync%25E2%2584%25A2%2520for%2520Microsoft%2520Outlook%25C2%25AE%26needsadmin%3Dtrue%26appguid%3D%7B7DF3B6EE-9890-4307-BDE5-E1F3FCB09771%7D%26appname%3DG%2520Suite%2520Migration%25E2%2584%25A2%2520for%2520Microsoft%2520Outlook%25C2%25AE%26needsadmin%3Dtrue/google-apps-sync/googleappssyncsetup.exe' 
$checksum       = '4E609C2FD5AD3D60DB9C4833AD6F4CA32C81436DB7F906C4A76C6FC1516FF6D2'
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\GSSMO.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE' 
  url            = $url
  softwareName   = 'Google Apps Sync*' 
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = ''
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs 
