﻿$ErrorActionPreference = 'Stop'
#https://www.techpowerup.com/download/techpowerup-gpu-z/
$packageName = 'gpu-z'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file        = $((Get-ChildItem $toolsDir\GPU-Z*.exe).name)

Remove-Item $ENV:ChocolateyInstall\bin\gpu-z*.exe  # delete old shims
Remove-Item $toolsDir\*.ignore                     # delete old .ignore files (2.18.0+)
Remove-Item $toolsDir\*.exe -Exclude $file         # delete old versions kept by upgrade
Write-Host "" | Out-File "$toolsDir\$file.ignore"            # create new .ignore file so shim isn't created

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\GPU-Z.lnk" -targetPath "$toolsDir\$file"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath "$toolsDir\$file"

# Upgrade instructions
# Replace .EXE