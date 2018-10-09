$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/28180/a08/win64_25.20.100.6323.exe'
$checksum64  = '70D750971905632F3F476C595032B7A0FEC1C9B7D9599FE4291D961FB7D48BDC'
$ahkExe      = 'AutoHotKey'
$ahkFile     = "$toolsDir\IGDInstall.ahk"

if (!(Get-IsWin10)){
    Write-Warning "  ** This version is only for Windows 10."
    throw
   }

if (!(Get-Is64)){
   Write-Warning "  ** This version is only for 64 bit OSes."
   throw
  }

if (!(Get-IsIntelVideo)){
    Write-Warning "  ** No Intel display adapter found."
    throw
   }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = ''
  checksum      = ''
  checksumType  = ''  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = ''
  softwareName  = 'Intel® Graphics Driver'
  }

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
