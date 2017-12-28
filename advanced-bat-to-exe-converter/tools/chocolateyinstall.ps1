$ErrorActionPreference = 'Stop'
$packageName    = 'advanced-bat-to-exe-converter'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.battoexeconverter.com/downloads/advancedbattoexeconverter.exe' 
$checksum       = '718E638164E20FC5464AA3DFB302DE35728B1B61C7FC0DD1D5DA47B1848BBC1A'
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

