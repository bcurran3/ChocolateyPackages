$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'plexamp'
  softwareName   = 'Plexamp*'
  fileType       = 'EXE'
  silentArgs     = '/S'
  file64         = "$toolsDir\Plexamp Setup $env:ChocolateyPackageVersion.exe"
  validExitCodes = @(0,1)
  }
  
Install-ChocolateyInstallPackage @packageArgs
Start-CheckandStop "PlexAmp" # test
Remove-Item $toolsDir\*.exe -Force -EA SilentlyContinue | Out-Null
