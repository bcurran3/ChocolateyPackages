$packageName= 'dell-update' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://downloads.dell.com/FOLDER04479996M/1/Dell-Update-Application_JV20K_WIN_1.9.40.0_A00.EXE'
$checksum   = '9799a06a3de39bbb0d5dd8ecc5f9ee5e8dfbcde22bfacb7b388a99e5f9b32101'

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
