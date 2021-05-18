$ErrorActionPreference = 'Stop'
$packageName = 'windows-10-update-assistant' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://download.microsoft.com/download/3/0/1/301147e7-e3d3-467e-a9eb-003a72840887/Windows10Upgrade9252.exe'
$checksum    = 'A83C1BA49475ED7DEAEF6E47766819317D9E6E50C7A5DB8175BDDF63BFBA5965'

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
