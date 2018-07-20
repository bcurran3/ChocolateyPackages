$ErrorActionPreference = 'Stop'
$packageName   = 'gsuite-sync-outlook'
$global:packageMaintainer = 'BCURRAN3'
$installerType = 'EXE'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://dl.google.com/tag/s/appguid%3D%7BBEBCAD10-F1BC-4F92-B4A7-9E2545C809ED%7D%26iid%3D%7BF9077F27-4034-7759-5FCA-021E35C0CE01%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DG%2520Suite%2520Sync%25E2%2584%25A2%2520for%2520Microsoft%2520Outlook%25C2%25AE%26needsadmin%3Dtrue%26appguid%3D%7B7DF3B6EE-9890-4307-BDE5-E1F3FCB09771%7D%26appname%3DG%2520Suite%2520Migration%25E2%2584%25A2%2520for%2520Microsoft%2520Outlook%25C2%25AE%26needsadmin%3Dtrue/google-apps-sync/googleappssyncsetup.exe' 
$checksum      = '5CC7FBEB4544B44389B19A01CAC6D9F2A6FD13E2F2FD6070C2E0057DAAA5EAC2'
$silentArgs    = '/silent /installsource silent /install'
$validExitCodes= @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'Google Apps Sync*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs 
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."
  
