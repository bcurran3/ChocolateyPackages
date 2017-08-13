$ErrorActionPreference = 'Stop'
$packageName    = 'grub2win' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/grub2win/grub2win.zip'
$checksum       = '540C82EA514E120721361B6C2B851C2B2C3E3D8DDEE28729DE1E6D6F4D555D6B'
$silentArgs     = 'setup'
$validExitCodes = @(0)
$fileLocation   = "$toolsDir\install\winsource\grub2win.exe"
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\g2winstall.ahk"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs "/$bootType"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'grub2win*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Sleep 10
Remove-Item "$toolsDir\install" -recurse | out-null
