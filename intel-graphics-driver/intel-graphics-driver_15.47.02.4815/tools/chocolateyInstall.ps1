$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = ''
$checksum    = ''
$url64       = 'https://downloadmirror.intel.com/27199/eng/win64_154702.4815.exe'
$checksum64  = 'CE2694E93D3D09295F1246A7580AC303EAF0B7DDB3A1B694120FF7AEC0233D87'
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
