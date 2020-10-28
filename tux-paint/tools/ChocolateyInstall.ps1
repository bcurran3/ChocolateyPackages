$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'tux-paint'
  fileType       = 'EXE'
  file           = "$toolsDir\tuxpaint-0.9.24-2-win32-i686-installer.exe"
  file64         = "$toolsDir\tuxpaint-0.9.24-2-win32-x86_64-installer.exe"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0,1)
  softwareName   = "Tux Paint*"
}
 
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null
