$ErrorActionPreference = 'Stop'
$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/29855/a08/igfx_win10_100.8681.exe'
$checksum64  = '90198DEC7D3210A317974A0757416E38E6E756C69CD33AAFC99FFD622DFDDED9'

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
  fileType      = 'EXE' 
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = '-overwrite -s'
  softwareName  = ''
  }

Install-ChocolateyPackage @packageArgs
