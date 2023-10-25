$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installer = Get-ChildItem "$toolsDir\tuxpaint-stamps*.exe"

$packageArgs = @{
  packageName    = 'tux-paint-stamps'
  fileType       = 'EXE'
  file           = "$installer"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0,1)
  softwareName   = 'Tux Paint Stamps*'
}
 
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe | Out-Null

# UPDATE INSTRUCTIONS:
# https://sourceforge.net/projects/tuxpaint/files/tuxpaint-stamps/
# Replace EXE with current one
