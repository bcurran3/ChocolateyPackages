$ErrorActionPreference = 'Stop'
$packageName = 'nubasic'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ZipFile     = "$toolsDir\nubasic-ide-"+"$ENV:ChocolateyPackageVersion"+"-setup_x64.zip"
 
Get-ChocolateyUnzip -FileFullPath $ZipFile -Destination $toolsDir
 
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$toolsDir\setup-vs64.exe"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  softwareName   = 'nuBASIC*'
}
 
Start-WaitandStop "vc_redist.x64"
Install-ChocolateyInstallPackage @packageArgs
 
Remove-Item $toolsDir\*.zip -Force -ErrorAction SilentlyContinue
Remove-Item $toolsDir\*.exe -Force -ErrorAction SilentlyContinue
