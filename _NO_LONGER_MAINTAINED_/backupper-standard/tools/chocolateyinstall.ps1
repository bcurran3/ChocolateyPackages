$ErrorActionPreference = 'Stop'
$packageName   = 'backupper-standard'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www2.aomeisoftware.com/download/adb/AOMEIBackupperStd.exe'
$checksum      = '15F7687F8EEA678B7527F1C90623673B36A26618C005CC3BE35FBD69BDE01A78'

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
