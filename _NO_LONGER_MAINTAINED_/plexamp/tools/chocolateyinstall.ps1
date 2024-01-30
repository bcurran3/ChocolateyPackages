$ErrorActionPreference = 'Stop'
$toolsDir  = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installer = Get-ChildItem "$toolsDir\Plexamp*.exe"

$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  softwareName   = 'Plexamp*'
  fileType       = 'EXE'
  silentArgs     = '/S'
  file64         = "$installer"
  validExitCodes = @(0,1)
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -Force -EA SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS:
# Replace .EXE file
