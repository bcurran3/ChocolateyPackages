$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = ''
$checksum    = ''
$url64       = 'https://downloadmirror.intel.com/26669/eng/win64_154516.4627.exe'
$checksum64  = '2BFE439F637C71AD1C894E0424BAE6382EAE4D75EAAB582A072B13E78847AD6E'
$silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
$bits = Get-ProcessorBits
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

if ($bits -eq 32)
  {
   Write-Host "This version is only for 64 bit OSes." -foreground "red" –backgroundcolor "blue"
   throw
  } else {  
    Install-ChocolateyPackage @packageArgs
   }
