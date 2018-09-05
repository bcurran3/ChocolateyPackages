$ErrorActionPreference = 'Stop'
$packageName    = 'tux-paint'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\tuxpaint-stamps-2018-09-01-win32-installer.exe"
$checksum       = '57E7D74A77073412B6D2036D1340B0A1182AB2D3CC47571F59144DEEB18A1BF4'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0,1)
  softwareName   = 'Tux Paint Stamps*'
}
 
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $url | out-null
