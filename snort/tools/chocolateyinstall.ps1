$ErrorActionPreference = 'Stop'
$packageName= 'snort' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.snort.org/downloads/snort/Snort_2_9_9_0_Installer.exe'
$checksum   = '901AB46C5652E8AEB7719B37FEBCDF35D506B018142DC2F0F03DA27D79AE4875'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '/S' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }

$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "SnortInstall.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList $ahkFile `
                         -PassThru

$ahkId = $ahkProc.Id

Install-ChocolateyPackage @packageArgs
