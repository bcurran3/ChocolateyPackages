$ErrorActionPreference = 'Stop'
$packageName    = 'VBoxGuestAdditions.install' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download.virtualbox.org/virtualbox/6.0.6/VBoxGuestAdditions_6.0.6.iso'
$checksum       = '832152B63630CEB2F89FB460EEB35B74A1218DF903758157F785122392D32CEB'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Set-Location "$toolsDir\cert"
& ./VBoxCertUtil.exe add-trusted-publisher vbox-sha256.cer

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$toolsDir\VBoxWindowsAdditions.exe"
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = ''
}
 
Install-ChocolateyInstallPackage @packageArgs
