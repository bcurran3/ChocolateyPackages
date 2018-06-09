$ErrorActionPreference = 'Stop'
$packageName    = 'grub2win' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/grub2win/grub2win.zip'
$checksum       = 'C7DEC26CC5ADCDCF96C0077270644228636998D105F649BE864490ADD4473F40'
$silentArgs     = 'setup'
$validExitCodes = @(0)
$fileLocation   = "$toolsDir\g2install.exe"
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
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'grub2win*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Sleep 10
Remove-Item $filelocation | out-null
