﻿$ErrorActionPreference = 'Stop'
$packageName     = 'choco-continuous-upgrader'
$toolsDir        = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$scriptDir       = "$(Get-ToolsLocation)\BCURRAN3"
$script          = 'CCU.ps1'

# Setup
# New storage location moving forward for all my Chocolatey scripts
if (!(Test-Path "$(Get-ToolsLocation)\BCURRAN3")) { New-Item -Path "$(Get-ToolsLocation)" -Name "BCURRAN3" -ItemType "Directory" | Out-Null }

# Install Script
# Move new files and support files (if applicable)
Move-Item "$toolsDir\CCU.*" "$scriptDir" -Force -ErrorAction SilentlyContinue

# Create "shim"
Install-ChocolateyPowershellCommand -PackageName 'CCU' -PSFileFullPath "$scriptDir\$script"

Write-Host "  ** Type `'CCU`' at the command line to run Chocolatey Continuous Upgrader." -Foreground Magenta
