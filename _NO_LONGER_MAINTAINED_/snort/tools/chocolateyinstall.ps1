$ErrorActionPreference = 'Stop'
$packageName = 'snort' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installer   = Get-ChildItem "$toolsDir\Snort*.exe"
$ahkExe        = 'AutoHotKey'
$ahkFile       = "$toolsDir\snort_install.ahk"

$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  softwareName   = "Snort"
  fileType       = 'EXE'
  silentArgs     = '/S'
  file64         = "$installer"
  validExitCodes = @(0)
  }

Start-Process $ahkExe $ahkFile
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\Snort*.exe -Force -EA SilentlyContinue | Out-Null