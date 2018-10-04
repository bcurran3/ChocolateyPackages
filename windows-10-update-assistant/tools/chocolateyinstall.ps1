$ErrorActionPreference = 'Stop'
$packageName = 'windows-10-update-assistant' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://download.microsoft.com/download/9/4/E/94E04254-741B-4316-B1DF-8CAEDF2DF16C/Windows10Upgrade9252.exe'
$checksum    = '02C384BD26C1F479D23870EBB498E8570CBEDF0E87325A6E79479F7AEB90665F'

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
