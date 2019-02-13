$ErrorActionPreference = 'Stop'
$packageName    = 'backupper-server'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www2.aomeisoftware.com/download/adb/ABServer.exe'
$checksum       = 'C541C5572199D4988DCB690FB782E28C1277149A128D4C2135747F9CB0A8EB2D'

if (!(Get-IsWinServer)) {
    Write-Warning "  ** This package is for Windows Server OSes only. Aborting."
    throw
  }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'AOMEI Backupper Server*' 
  checksum      = $checksum 
  checksumType  = 'sha256'  
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  
  validExitCodes= @(0,1)  
  }
Install-ChocolateyPackage @packageArgs
