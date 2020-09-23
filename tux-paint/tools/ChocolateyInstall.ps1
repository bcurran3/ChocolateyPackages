$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'tux-paint'
  fileType       = 'EXE'
  file           = "$toolsDir\tuxpaint-0.9.24-1-win32-installer.exe"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0,1)
  softwareName   = "Tux Paint*"
}
 
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe | Out-Null
