$packageName   = 'backupper-standard'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www2.aomeisoftware.com/download/adb/BackupperFull.exe'
$checksum      = 'BFA78718FDC561A4515B136684A252F59BEFCCBE1EA0B1EE2E4D3D14FBA5F08A'

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
