$packageName    = 'smart-control-center' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.downloads.netgear.com/files/GDC/S3300/SCC-Release-V1.1.3.3.exe'
$checksum       = '0DCD16C5037CA5B3A29BA8596280AAD24F939A71CBEC79256DA312F5D60B22FD'
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "SCCinstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = ''
  softwareName  = 'SmartControlCenter' 
  }
Install-ChocolateyPackage @packageArgs
