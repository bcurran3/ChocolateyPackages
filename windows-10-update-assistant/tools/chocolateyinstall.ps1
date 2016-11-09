$ErrorActionPreference = 'Stop'
$packageName= 'windows-10-update-assistant' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/0/4/7/047889D0-578C-4A44-A38F-7F30A6CB3809/current-version/Windows10Upgrade9252.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = '81B224CC37E5C6FD68186182B6FBC866F6CFBE9D04BAE0BD5D8B4706E53446A9'
  checksumType  = 'sha256'
  silentArgs   = '' 
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

