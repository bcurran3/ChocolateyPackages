$ErrorActionPreference = 'Stop';
$packageName = 'revo-uninstaller'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\revosetup.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file            = $url
  softwareName   = 'Revo Uninstaller*'
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-" 
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -force | Out-Null
