$ErrorActionPreference = 'Stop'
$packageName = 'windows-10-update-assistant' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://download.microsoft.com/download/0/4/7/047889D0-578C-4A44-A38F-7F30A6CB3809/current-version/Windows10Upgrade9252.exe'
$checksum    = '07CC187706C908D0155AEF6EC1614D69776F59B34387C0D921E8CE15CA85602B'

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

