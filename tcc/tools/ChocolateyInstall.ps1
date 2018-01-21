$packageName = 'tcc'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileType    = 'exe'
$silentArgs  = '/quiet'
$url         = 'https://jpsoft.com/downloads/v22/tcc.exe'
$checksum    = '1DF6112CEE3F58D45B39073A1C95D3C29362A07867169E4E5A88BA4DF1B4177B'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $fileType 
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'TCC 22' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs