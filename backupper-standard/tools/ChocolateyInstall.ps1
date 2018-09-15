$packageName   = 'backupper-standard'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'http://www.aomeisoftware.com/download/adb/BackupperFull.exe'
$checksum      = 'A2B04C0F75F7A41EC9910B1365771A7A5C147495C20EAB53F8FCA59FB689EB13'

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
