$ErrorActionPreference = 'Stop'
$packageName    = 'advanced-bat-to-exe-converter'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.battoexeconverter.com/downloads/advancedbattoexeconverter.exe' 
$checksum       = 'E87961E0DF832A47DBB90FE44B0E4F8A077EE53D53187FA274CD3A640C2E9463'
$silentArgs     = ''
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "AB2ECInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'Advanced BAT to EXE Converter*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs 

