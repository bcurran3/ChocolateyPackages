$ErrorActionPreference = 'Stop'
$packageName = 'windows-11-installation-assistant' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://go.microsoft.com/fwlink/?linkid=2171764'
$checksum    = '9D04E6C0EEF448763AD50BF094C8076F4CE6673A83232FB200355F20F77F021A'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '' 
  softwareName  = 'Windows 11 Installation Assistant' 
}

Install-ChocolateyPackage @packageArgs
Start-Sleep -Seconds 5
Start-CheckandStop "Windows10UpgraderApp"
