$ErrorActionPreference = 'Stop'
$packageName    = 'qdir'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits

$packageArgs = @{
  packageName    = $packageName
  Destination    = $toolsDir
  FileFullPath   = "$toolsDir\Q-Dir_Installer.zip"
  FileFullPath64 = "$toolsDir\Q-Dir_Installer_x64.zip"
}

Get-ChocolateyUnzip @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$toolsDir\Q-Dir_Installer_UC.exe"
  file64         = "$toolsDir\Q-Dir_Installer_x64.exe"
  silentArgs     = '/S langid=1'
  validExitCodes = @(0,1)
  softwareName   = 'Q-Dir'
}
 
Install-ChocolateyInstallPackage @packageArgs

Install-BinFile -Name qdir -Path $env:ProgramFiles\Q-Dir\Q-Dir.exe
Remove-Item "$toolsDir\*.zip" -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.exe" -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.ignore" -ErrorAction SilentlyContinue | Out-Null
