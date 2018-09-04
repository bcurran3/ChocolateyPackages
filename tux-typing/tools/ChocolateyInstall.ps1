$ErrorActionPreference = 'Stop'
$packageName    = 'tux-of-math-command'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\tuxtype-1.8.1-win32-installer.exe"
$checksum       = '9B699BAE29BA56AA12E2033780768B7C5756E728523DE984896992BC73EC65A5'

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
