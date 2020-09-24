# https://sourceforge.net/projects/warzone2100/files/latest/download
$ErrorActionPreference = 'Stop'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName  = 'warzone2100'
  fileType     = 'EXE'
  file         = "$toolsDir\warzone2100_win_x86_installer.exe"
  silentArgs   = '/S'
  softwareName = 'Warzone 2100*'
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -Force | Out-Null
Remove-Item $toolsDir\*.ignore -Force | Out-Null
