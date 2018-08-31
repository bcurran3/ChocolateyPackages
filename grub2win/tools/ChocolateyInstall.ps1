$ErrorActionPreference = 'Stop'
$packageName    = 'grub2win' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/grub2win/grub2win.zip'
$checksum       = 'E76BD8DC8FFB716149210E41A74B8977921353D480CCEE2D36F615A7C1BECC5A'
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
  silentArgs    = 'setup'
  validExitCodes= @(0)
  softwareName  = 'grub2win*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Sleep 10
Remove-Item $filelocation | out-null
