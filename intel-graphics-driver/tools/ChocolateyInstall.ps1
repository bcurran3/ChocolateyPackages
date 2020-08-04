$ErrorActionPreference = 'Stop'
$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/29274/a08/igfx_win10_100.7584.exe'
$checksum64  = '702503DF87126284C469EF3E669CA2856F48E840A0798BD7BC285E935C846F3C'

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
  url           = ''
  checksum      = ''
  checksumType  = ''  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = '-overwrite -s -report $env:tmp\igfx_win10.txt'
  softwareName  = ''
  }

Install-ChocolateyPackage @packageArgs
