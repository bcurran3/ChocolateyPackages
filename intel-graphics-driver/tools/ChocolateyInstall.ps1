$ErrorActionPreference = 'Stop'
$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/30579/a08/igfx_win_100.9684.exe'
$checksum64  = '91FA5A58175339C100FEFA05A97D4011ACE4DD9C9924661255BC0C90BEA04906'

if (!(Get-IsWin10)){
    Write-Warning "  ** This version is only for Windows 10."
    throw
   }

if (!(Get-IsIntelVideo)){
    Write-Warning "  ** No Intel display adapter found."
    throw
   }

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE' 
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = "--overwrite --silent --report $toolsDir\install.log"
  softwareName   = ''
  validExitCodes = @(0, 3010, 1641, 14)
   }

Install-ChocolateyPackage @packageArgs
