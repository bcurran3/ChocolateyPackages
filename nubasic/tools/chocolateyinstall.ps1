$ErrorActionPreference = 'Stop'
$packageName = 'nubasic'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits        = Get-ProcessorBits
$file64       = "$toolsDir\nubasic-ide-"+"$ENV:ChocolateyPackageVersion"+"-setup_x64.zip"
$Installer   = "$toolsDir\setup-vs64.exe"
 
Get-ChocolateyUnzip -FileFullPath $file64 -Destination $toolsDir
 
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $Installer
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  softwareName   = 'nuBASIC*'
}
 
Start-WaitandStop "vc_redist.x64"
Install-ChocolateyInstallPackage @packageArgs
 
Remove-Item $file64 -Force -ErrorAction SilentlyContinue
Remove-Item $Installer -Force -ErrorAction SilentlyContinue