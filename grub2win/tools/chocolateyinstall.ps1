$ErrorActionPreference = 'Stop'
$packageName    = 'grub2win' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/grub2win/grub2win.zip'
$checksum       = 'BC94542625D78312CB3C6C1B1EE5C9AD7800B142EF7517104FF9BC5FFF5531B0'
$fileLocation   = "$toolsDir\setup.exe"
$ahkExe         = 'AutoHotKey'

if (Test-Path $env:SystemDrive\grub2){
    $ahkFile = "$toolsDir\G2Wupgrade.ahk"
  } else {
    $ahkFile = "$toolsDir\G2Winstall.ahk"
}

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
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = 'setup'
  validExitCodes = @(0)
  softwareName   = 'grub2win*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Sleep 10
Remove-Item $filelocation | Out-Null
