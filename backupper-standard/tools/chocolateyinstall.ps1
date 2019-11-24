$ErrorActionPreference = 'Stop'
$packageName   = 'backupper-standard'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www2.aomeisoftware.com/download/adb/BackupperFull.exe'
$checksum      = 'BD99C793F5F7B3FB9DC68CDFFBB00EA25D26F1C2219F16CFA28102CBC8BE9D9C'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'AOMEI Backupper Standard*' 
  checksum      = $checksum 
  checksumType  = 'sha256'  
  }

Install-ChocolateyPackage @packageArgs
