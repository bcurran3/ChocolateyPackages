$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = ''
$checksum    = ''
$url64       = 'https://downloadmirror.intel.com/27847/a08/win64_24.20.100.6136.exe'
$checksum64  = '105D1CD88B1D3CA5DE1950032E99403CCAE1B2A9394DE47CB2805E1B802492F5'
$silentArgs  = '/S' 
$bits        = Get-ProcessorBits
$card        = wmic path win32_VideoController get name
$ahkExe      = 'AutoHotKey'
$ahkFile     = Join-Path $toolsDir "IGDInstall.ahk"

if ($bits -eq 32)
  {
   Write-Host "This version is only for 64 bit OSes." -foreground "red" 
   throw
  }

if ($card -match "Intel")
  {
   write-host "You've got $card!" -foreground "green" 
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
  softwareName  = 'Intel® Graphics Driver' 
  }

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs

