$ErrorActionPreference = 'Stop'
$packageName    = 'ultimate-settings-panel'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName  = $packageName
  Destination  = "$toolsDir\extracted"
  FileFullPath = "$toolsDir\Ultimate-Settings-Panel.zip"
}

Get-ChocolateyUnzip @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  file           = "$toolsDir\extracted\Ultimate-Settings-Panel\Installer\Ultimate Settings Panel.msi"
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0)
  softwareName   = 'Ultimate Settings Panel*'   
}

Install-ChocolateyInstallPackage @packageArgs	

Remove-Item "$toolsDir\extracted" -Recurse -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\Ultimate-Settings-Panel.zip" -Force -EA SilentlyContinue | Out-Null
