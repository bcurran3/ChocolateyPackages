$ErrorActionPreference = 'Stop'
$packageName    = 'ultimate-settings-panel'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\Ultimate-Settings-Panel.zip"
$UnzippedEXE    = 'Ultimate Settings Panel.msi'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = "$toolsDir\extracted"
  fileType       = 'ZIP' 
  url            = $url
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  file           = "$toolsDir\extracted\Installer\$UnzippedEXE"
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0)
  softwareName   = 'Ultimate Settings Panel*'   
}

Install-ChocolateyInstallPackage @packageArgs	

Remove-Item "$toolsDir\extracted" -Recurse -Force -EA SilentlyContinue | Out-Null
Remove-Item $url -Force -EA SilentlyContinue | Out-Null
