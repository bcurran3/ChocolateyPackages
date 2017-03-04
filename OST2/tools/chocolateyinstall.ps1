$ErrorActionPreference = 'Stop'
$packageName= 'ost2' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://d.4team.biz/files/ost2_setup.exe'
$checksum   = 'D8F77462BA843DC890DC6BECD5BC93EF252F2CCCF649CC36D0A19993F3ED3437'

$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "OST2install.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList $ahkFile `
                         -PassThru

$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = ''
  softwareName  = 'OST2*' 
  }
Install-ChocolateyPackage @packageArgs
