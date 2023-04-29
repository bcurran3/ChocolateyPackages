$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysVersion = $ENV:ChocolateyPackageVersion.replace('.','-')

$packageArgs = @{
  packageName    = 'tux-paint-stamps'
  fileType       = 'EXE'
  file           = "$toolsDir\tuxpaint-stamps-"+"$TodaysVersion"+"-windows-installer.exe"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0,1)
  softwareName   = 'Tux Paint Stamps*'
}
 
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe | Out-Null

# UPDATE INSTRUCTIONS:
# https://sourceforge.net/projects/tuxpaint/files/tuxpaint-stamps/
# Replace EXE with current one
