# https://www.danhinsley.com/downloads/MetaXSetup.msi
$ErrorActionPreference = 'Stop'
$packageName = 'metax'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  file           = "$toolsDir\MetaXSetup.msi"
  silentArgs     = '/quiet /qn /norestart'
  softwareName   = 'MetaX for Windows' 
  validExitCodes = @(0, 3010, 1641)
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.msi -Force | Out-Null
