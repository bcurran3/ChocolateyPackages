$packageName   = 'backupper-standard'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'http://www.aomeisoftware.com/download/adb/BackupperFull.exe'
$checksum      = '128FF651DD28C69D06FDDBAD1F8F476B8603FE7435833ACE2ADDB17A46B08DA6'

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
