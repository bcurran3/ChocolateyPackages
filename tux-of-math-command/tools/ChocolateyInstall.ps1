$ErrorActionPreference = 'Stop'
$packageName    = 'tux-of-math-command'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\tuxmath-2.0.2-win32-installer.exe"
$checksum       = '155173F1CB3258D971E8969B0C3E55EEBDB8F093D93FC342CF8DD8223AC50DA5'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  checksum       = $checksum
  silentArgs     = '/S'
  validExitCodes = @(0,1)
  softwareName   = ''
}
 
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $url | out-null
