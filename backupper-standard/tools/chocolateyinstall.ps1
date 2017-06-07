$packageName   = 'backupper-standard'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'http://www.aomeisoftware.com/download/adb/BackupperFull.exe'
$checksum      = '302FB4701AFE0275540D51A39A7F80F6442C9427DF29C57AEAEE4E49681F88CC'
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

