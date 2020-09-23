$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'tux-paint-stamps'
  fileType       = 'EXE'
  file           = "$toolsDir\tuxpaint-stamps-2020-05-29-win32-installer.exe"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0,1)
  softwareName   = 'Tux Paint Stamps*'
}
 
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe | Out-Null
