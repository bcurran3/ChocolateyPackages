$packageName = 'intel-graphics-driver' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = ''
$checksum    = ''
$url64       = 'https://downloadmirror.intel.com/27892/a08/win64_24.20.100.6194.exe'
$checksum64  = '7E707A32342B7692FFF9F45291E1B5DFA3FD700162E8AD62FEF70DDB1033C458'
$silentArgs  = '/S' 
$softwareName= 'Intel® Graphics Driver' 
$card        = wmic path win32_VideoController get name
$ahkExe      = 'AutoHotKey'
$ahkFile     = Join-Path $toolsDir "IGDInstall.ahk"

if (Get-Is32)
  {
   Write-Host "This version is only for 64 bit OSes." -foreground "red" 
   throw
  }

if (Get-IsIntelVideo){
  } else {
    write-host "No Intel display adapters found. Aborting." -foreground "red"
    throw
   }

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
  softwareName  = $softwareName
  }

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs

