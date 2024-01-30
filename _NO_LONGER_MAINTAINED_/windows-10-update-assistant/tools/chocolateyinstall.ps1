$ErrorActionPreference = 'Stop'
$packageName = 'windows-10-update-assistant' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://download.microsoft.com/download/4/8/3/483976ae-b4b1-490d-bd5f-74fdc44bb84e/Windows10Upgrade9252.exe'
$checksum    = 'C0424D0AE06CA1E6E0249B40D33AC40D74075856D543EC0924884664FBA52B79'

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

# UPDATE INSTRUCTIONS
# https://www.microsoft.com/en-us/software-download/windows10
# Update DL URL and checksum

