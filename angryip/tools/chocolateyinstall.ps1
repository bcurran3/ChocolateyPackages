﻿# https://angryip.org/download/#windows
$ErrorActionPreference = 'Stop'
$packageName = 'angryip'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = "$toolsDir\ipscan-$ENV:ChocolateyPackageVersion-setup.exe"
  silentArgs    = '/S'
  softwareName  = 'Angry IP Scanner*' 
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -Force | Out-Null
Remove-Item $toolsDir\*.ignore -Force | Out-Null
