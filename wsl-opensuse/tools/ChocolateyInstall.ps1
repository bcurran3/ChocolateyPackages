# openSUSE-42 doesn't support being silently installed. This script kludges it.
$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-opensuse'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://aka.ms/wsl-opensuse-42'
$checksum       = '7E8D474A53631C4843C7F209E3530B777A40F6DA12B9C91AEA418071D76DCA02'
$unzipLocation  = "$toolsDir\unzipped"

New-Item $unzipLocation -type directory -ErrorAction SilentlyContinue | out-null

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# open openSUSE-42 installer in a new window
Set-Location -Path $unzipLocation
Start-Process openSUSE-42.exe

Write-Host "  ** When you see ""Installation successful!"" in the other window, you may close it." -foreground magenta
Write-Host "  ** Otherwise, just wait up to 25 seconds and it will close automatically." -foreground magenta

# wait for openSUSE-42 installer to finish extracting files
while (!(Test-Path $unzipLocation\rootfs\var\tmp)){
       Start-Sleep -Seconds 15
      }

# wait 10 more seconds to make sure the files IN rootfs\var\tmp get extracted
Start-Sleep -Seconds 10

# terminate openSUSE-42.EXE ~when it hits the "Enter new UNIX username:" prompt (meaning installation has finished)
Start-CheckandStop "openSUSE-42"

Write-Host "  ** root is the default user upon running WSL/openSUSE-42." -foreground magenta
