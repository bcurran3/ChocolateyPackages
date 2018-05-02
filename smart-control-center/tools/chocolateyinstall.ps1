$packageName    = 'smart-control-center' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.downloads.netgear.com/files/GDC/S3300/SCC-Release-V1.1.3.4.exe'
$checksum       = '24DE68AEBE95306EE30724A8183ADC1B5269CF17AA46C9F24E03723E275436D7'
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
