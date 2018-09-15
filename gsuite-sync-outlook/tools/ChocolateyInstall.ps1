$ErrorActionPreference = 'Stop'
$packageName   = 'gsuite-sync-outlook'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://dl.google.com/tag/s/appguid%3D%7BBEBCAD10-F1BC-4F92-B4A7-9E2545C809ED%7D%26iid%3D%7BA3125EAB-3065-22F6-446F-F5216E903919%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DG%2520Suite%2520Sync%25E2%2584%25A2%2520for%2520Microsoft%2520Outlook%25C2%25AE%26needsadmin%3Dtrue%26appguid%3D%7B7DF3B6EE-9890-4307-BDE5-E1F3FCB09771%7D%26appname%3DG%2520Suite%2520Migration%25E2%2584%25A2%2520for%2520Microsoft%2520Outlook%25C2%25AE%26needsadmin%3Dtrue/google-apps-sync/googleappssyncsetup.exe' 
$checksum      = 'BCFCD1DDA974B6C00FA64DD4B5786C380E0D3FF558884122DC9EA046E3CE886C'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'Google Apps Sync*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/silent /installsource silent /install'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs 
