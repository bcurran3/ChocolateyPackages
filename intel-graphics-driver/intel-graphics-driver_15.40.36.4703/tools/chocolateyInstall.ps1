$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloadmirror.intel.com/26984/eng/win32_154036.4703.exe'
$checksum    = '7CE89B8B0689CEBD08652C55D5AE0FC641AFC5692D15319D2A19176B1B4FBBD2'
$url64       = 'https://downloadmirror.intel.com/26984/eng/win64_154036.4703.exe'
$checksum64  = 'B7A68967A3F5E697B0B21D6330E156037BBFA30D737A179E843E1FF0892901AB'
$silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
$ahkExe      = 'AutoHotKey'
$ahkFile     = Join-Path $toolsDir "IGDInstall.ahk"

$card = wmic path win32_VideoController get name
if ($card -match "Intel")
  {
   write-host "You've got $card!" -foreground "green" –backgroundcolor "blue"
  } else {
   write-host "No Intel display adapters found. Aborting." -foreground "red" –backgroundcolor "blue"
   throw
   }

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = $silentArgs
  softwareName  = 'Intel® Graphics Driver' 
  }
Install-ChocolateyPackage @packageArgs
