$ErrorActionPreference = 'Stop'
$packageName = 'drobo-dashboard' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://files.drobo.com/webrelease/dashboard/Drobo-Dashboard-3.1.1.exe'
$checksum    = '371A568C3B78F5A02DFBB2C336B69E87B7167BEE82D01A05806F40225DE7574A'
$ahkExe      = 'AutoHotKey'
$ahkFile     = Join-Path $toolsDir "DDinstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = ''
  softwareName  = 'Drobo Dashboard' 
  }

Install-ChocolateyPackage @packageArgs
