$ErrorActionPreference = 'Stop'
$packageName = 'readynas-remote' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://remote.readynas.com/ReadyNASRemoteSetup.exe'
$checksum    = '81952B2568A0C21254D39DC4FF07AF4F00010DEDA8CA959505E30D28DE7CD13C'

$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "RNRinstall.ahk"
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
  silentArgs    = ''
  softwareName  = 'ReadyNAS Remote' 
  }
Install-ChocolateyPackage @packageArgs
