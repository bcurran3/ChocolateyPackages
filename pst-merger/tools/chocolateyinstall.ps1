$packageName = 'pst-merger' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://d.4team.biz/files/pstmerger_setup.exe'
$checksum    = 'FDEB0680222F70C0F5C1749FA3601EAD66692267AEBA07FA0ACAE23433096018'
$ahkExe      = 'AutoHotKey'
$ahkFile     = Join-Path $toolsDir "PSTMergerInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs    = '' 
  softwareName  = '4Team PST Merger*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  }
  
Install-ChocolateyPackage @packageArgs

