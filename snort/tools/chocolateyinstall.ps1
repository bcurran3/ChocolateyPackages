$ErrorActionPreference = 'Stop'
$packageName= 'snort' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.snort.org/downloads/snort/Snort_2_9_8_3_Installer.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '/S' 
  checksum      = '9DA62FBA43F1F9243A1D7B6856584EF18F4DFB47CB58365CCCA81D301BD5EAC8'
  checksumType  = 'sha256'  
  }

$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "SnortInstall.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList $ahkFile `
                         -PassThru

$ahkId = $ahkProc.Id

Install-ChocolateyPackage @packageArgs
