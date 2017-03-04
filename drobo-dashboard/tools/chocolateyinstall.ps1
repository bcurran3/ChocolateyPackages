$ErrorActionPreference = 'Stop'
$packageName = 'drobo-dashboard' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://files.drobo.com/webrelease/dashboard/Drobo-Dashboard-3.0.0.exe'
$checksum    = '6E059B0F8311DDCF29573D8A33C054284585858C3CEE892E1C94C6976CC0D31F'

$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "DDinstall.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList $ahkFile `
                         -PassThru

$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = '/S /v /qn'
  softwareName  = 'Drobo Dashboard' 
  }
Install-ChocolateyPackage @packageArgs
