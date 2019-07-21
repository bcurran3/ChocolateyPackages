$ErrorActionPreference = 'Stop'
$packageName = 'windows-10-update-assistant' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://download.microsoft.com/download/B/C/F/BCF2D763-F118-4A85-9E63-AEAED1B9E98E/Windows10Upgrade9252.exe'
$checksum    = '373170C1B35CD0380808ADBE3FB43A312D0BD70F6DB411CAE71BBD34166EE75B'

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
