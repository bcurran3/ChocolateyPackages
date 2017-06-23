$ErrorActionPreference = 'Stop'
$packageName = 'windows-10-update-assistant' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://download.microsoft.com/download/0/1/6/01677C03-1D89-49FD-B49B-87B0F36B00D1/Windows10Upgrade9252.exe'
$checksum    = '26511E8F34CCDF3E4997E5F23E57462187E6B33D74ADC19D89145F9AF28CCFD7'

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

Start-Sleep -s 2
if((get-process "Windows10UpgraderApp" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "Windows 10 Upgrade Assistant currently NOT running." 
  }else{ 
    Write-Host "Stopping Windows 10 Upgrade Assistant process..."
    Stop-Process -processname "Windows10UpgraderApp"
  }

