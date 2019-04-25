$ErrorActionPreference = 'Stop'
$packageName    = 'backupper-server'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www2.aomeisoftware.com/download/adb/ABServer.exe'
$checksum       = '793C6D95EEEBF0E9711F48A6D8F2A5B4FF098793379F7D023773A62DAD99806C'

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
