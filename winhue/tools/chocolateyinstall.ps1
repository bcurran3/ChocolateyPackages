$ErrorActionPreference = 'Stop'
$packageName    = 'winhue'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE' 
  file           = "$toolsDir\WinHue."+$ENV:ChocolateyPackageVersion+".Setup.exe"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  softwareName   = 'WinHue*'
}

Install-ChocolateyInstallPackage @packageArgs
  