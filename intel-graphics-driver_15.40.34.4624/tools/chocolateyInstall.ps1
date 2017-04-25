$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloadmirror.intel.com/26682/eng/win32_154034.4624.exe'
$checksum    = '162D351AA44BC281E7C4AD9FB204E1288AAF9EA949F353CF4BE5966E8C021102'
$url64       = 'https://downloadmirror.intel.com/26682/eng/win64_154034.4624.exe'
$checksum64  = '003F048F952E97E848D2AB5AD975EE8C6FFAA4C9D60A8656480E8AEAD7585902'
$silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
$ahkExe      = 'AutoHotKey'
$ahkFile     = Join-Path $toolsDir "IGDInstall.ahk"

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
