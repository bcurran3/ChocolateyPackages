$ErrorActionPreference = 'Stop'
$packageName= 'hfsexplorer'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = "$toolsDir\hfsexplorer-0.23.1-setup.exe"
  silentArgs    = '/S'
  softwareName  = 'HFSExplorer 0.23.1'
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -Force | Out-Null
Remove-Item $toolsDir\*.ignore -Force | Out-Null
