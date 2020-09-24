﻿$ErrorActionPreference = 'Stop'
#https://www.techpowerup.com/download/techpowerup-gpu-z/
$packageName = 'gpu-z'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$PortableEXE = "$toolsDir\GPU-Z."+$ENV:ChocolateyPackageVersion+".exe"

Remove-Item $ENV:ChocolateyInstall\bin\gpu-z*.exe # delete old shims
Remove-Item $toolsDir\*.exe -Exclude "GPU-Z.$ENV:ChocolateyPackageVersion.exe" # deleted old versions kept by upgrade
Remove-Item $toolsDir\*.ignore  # delete old .ignore files (2.18.0+)
Write-Host "" | Out-File "$toolsDir\GPU-Z.$ENV:ChocolateyPackageVersion.ignore" # create .ignore file so shim isn't created

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\GPU-Z.lnk" -targetPath $PortableEXE
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath $PortableEXE
