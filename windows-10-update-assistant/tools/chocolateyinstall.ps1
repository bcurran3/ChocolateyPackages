$ErrorActionPreference = 'Stop'
$packageName = 'windows-10-update-assistant' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://download.microsoft.com/download/f/1/9/f19ea9d5-1b5f-4a4d-9f50-04cbf63dc9c6/Windows10Upgrade9252.exe'
$checksum    = 'D2447038C5DA0853F3F12F12B3589B4E3445889FB306D2DCFCC37FCA0561186C'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '' 
  softwareName  = 'Windows 10 Update Assistant*' 
}

Install-ChocolateyPackage @packageArgs
Start-Sleep -Seconds 5
Start-CheckandStop "Windows10UpgraderApp"
