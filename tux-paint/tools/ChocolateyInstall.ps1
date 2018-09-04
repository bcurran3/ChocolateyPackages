$ErrorActionPreference = 'Stop'
$packageName    = 'tux-paint'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\tuxpaint-0.9.23-win32-installer.exe"
$checksum       = '52C43AA4925458421A20506F64659FABAD5A8939947ADB4B4C26A8BDC90E08E5'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  checksum       = $checksum
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0,1)
  softwareName   = 'Tux Paint*'
}
 
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $url | out-null
