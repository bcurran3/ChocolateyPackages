$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/27988/a08/win64_24.20.100.6286.exe'
$checksum64  = 'CAE6EED1E63F54AA83A68336412C568B3322AB40CED6F36A63DE537A0DB3A907'
$ahkExe      = 'AutoHotKey'
$ahkFile     = Join-Path $toolsDir "IGDInstall.ahk"

if (Get-Is32){
   Write-Host "This version is only for 64 bit OSes." -ForeGround red
   throw
  }

if (!(Get-IsIntelVideo)){
    Write-Host "No Intel display adapters found. Aborting." -ForeGround red
    throw
   }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = ''
  checksum      = ''
  checksumType  = 'sha256'  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = ''
  softwareName  = 'Intel® Graphics Driver'
  }

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
