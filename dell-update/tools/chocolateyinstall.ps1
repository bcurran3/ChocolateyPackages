$packageName = 'dell-update' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.dell.com/FOLDER04915494M/1/Dell-Update-Application_V3DT0_WIN_2.1.3.0_A00.EXE'
$checksum    = 'FAD20C76782650917917E2F950C5E3ECCABAF3E86779559FF05FF4785111A1BC'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/S' 
  softwareName  = 'Dell Update*' 
}

Install-ChocolateyPackage @packageArgs
