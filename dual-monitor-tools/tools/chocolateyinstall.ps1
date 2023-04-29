#https://sourceforge.net/projects/dualmonitortool/
$ErrorActionPreference = 'Stop'
$packageName   = 'dual-monitor-tools'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ShortVer      = $ENV:ChocolateyPackageVersion.trim('.0.0')
  
  $packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = "$toolsDir\DualMonitorTools-$ShortVer.msi"
  silentArgs     = '/quiet /qn /norestart'
  softwareName  = 'Dual Monitor Tools'
  validExitCodes = @(0, 3010, 1641)
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.msi -Force | Out-Null

# UPDATE INSTRUCTIONS:
# Download latest MSI file and place in tools
# Delete old MSI file
