$ErrorActionPreference = 'Stop'
$packageName    = 'grub2win' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/grub2win/grub2win.zip'
$checksum       = '059768A3A6C647EC4F0DB657FF6A2818821B1E3807C31ED2763E344682A4BDC1'
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
