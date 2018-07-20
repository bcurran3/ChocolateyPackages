$ErrorActionPreference = 'Stop'
$packageName = 'windows-10-update-assistant' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://download.microsoft.com/download/E/0/A/E0A1E6A8-26F8-4399-9C22-27419BC37B51/Windows10Upgrade9252.exe'
$checksum    = '9CC35D40DBA8645F817921C44932D48C9F590B253EF69CD24E6E525B2475BD5A'

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

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."

Start-Sleep -s 2
Start-CheckandStop "Windows10UpgraderApp"
