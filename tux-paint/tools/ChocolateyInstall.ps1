﻿$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'tux-paint'
  fileType       = 'EXE'
  file           = "$toolsDir\tuxpaint-"+"$ENV:ChocolateyPackageVersion"+"-windows-i686-installer.exe"
  file64         = "$toolsDir\tuxpaint-"+"$ENV:ChocolateyPackageVersion"+"-windows-x86_64-installer.exe"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0,1)
  softwareName   = "Tux Paint*"
}
 
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS:
# https://tuxpaint.org/download/windows/
# Replace EXE installer files with new ones
