$packageName    = 'VBoxGuestAdditions.install' 
$url            = 'https://download.virtualbox.org/virtualbox/5.2.12/VBoxGuestAdditions_5.2.12.iso'
$checksum       = 'B81D283D9EF88A44E7AC8983422BEAD0823C825CBFE80417423BD12DE91B8046'
$silentArgs     = '/S'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0)
$fileLocation   = "$toolsDir\VBoxWindowsAdditions.exe"

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
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = ''
}
 
Install-ChocolateyInstallPackage @packageArgs
