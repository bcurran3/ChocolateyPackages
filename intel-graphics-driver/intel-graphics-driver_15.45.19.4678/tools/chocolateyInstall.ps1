$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = ''
$checksum    = ''
$url64       = 'https://downloadmirror.intel.com/26836/eng/win64_154519.4678.exe'
$checksum64  = '4744ECF5094EE948977D16C5F1F1EDA24823DC52C2F4D535C9CDCC8CF25EE523'
$silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
$bits        = Get-ProcessorBits
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
