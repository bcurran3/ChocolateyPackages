$ErrorActionPreference = 'Stop'
$packageName = 'windows-10-update-assistant' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://download.microsoft.com/download/B/8/2/B8246627-1CFB-4F4E-BB77-E67B59EC63FE/Windows10Upgrade9252.exe'
$checksum    = '40D7152FE33DB443385A78C27567C1C60AC7258E73FE2DE7AF2C26ACC3D37939'

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

