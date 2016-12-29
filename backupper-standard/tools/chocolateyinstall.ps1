$packageName   = 'backupper-standard'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'http://www.aomeisoftware.com/download/adb/BackupperFull.exe'
$checksum      = '760CC8929E42888A49FEDEA859FBE14B9557A3A4C6F4F88A56916F3215B7A4D8'
$silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'AOMEI Backupper Standard*' 
  checksum      = $checksum 
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs

