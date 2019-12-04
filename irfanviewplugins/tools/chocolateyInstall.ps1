$ErrorActionPreference = 'Stop'
$packageName    = 'irfanviewplugins'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = Join-Path $toolsDir "iview453_plugins_setup.exe"
$url64          = Join-Path $toolsDir "iview453_plugins_x64_setup.exe"
					  
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  file           = $url
  file64         = $url64
  validExitCodes = @(0)
  silentArgs     = '/silent'
  softwareName   = ''
  checksum       = '0dd3763a6b789273633a052b25d5674a26af0d7edc98c2a95abf2fe8b11bb391'
  checksumType   = 'sha256'
  checksum64     = 'ac8d27b1241ef91e80a73bfc672342be7317f7d8bf47a615a00d01f5090f3d43'
  checksumType64 = 'sha256'
}

Install-ChocolateyInstallPackage @packageArgs  

#Remove-Item $url | Out-Null
#Remove-Item $url64 | Out-Null
