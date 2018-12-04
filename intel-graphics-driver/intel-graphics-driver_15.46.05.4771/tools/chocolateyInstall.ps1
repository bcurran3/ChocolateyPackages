$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = ''
$checksum    = ''
$url64       = 'https://downloadmirror.intel.com/27058/eng/win64_154605.4771.exe'
$checksum64  = 'A66D16398EAC66F3D30FBB2A81EE2E35F40DC81C2206F7D52ADBB02086E291F1'
$silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
$bits        = Get-ProcessorBits
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
    Start-Process $ahkExe $ahkFile
    Install-ChocolateyPackage @packageArgs
   }
