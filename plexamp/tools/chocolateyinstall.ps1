$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  softwareName   = 'Plexamp*'
  fileType       = 'EXE'
  silentArgs     = '/S'
  file64         = "$toolsDir\Plexamp Setup $env:ChocolateyPackageVersion.exe"
  validExitCodes = @(0,1)
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -Force -EA SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS:
# Replace .EXE file
