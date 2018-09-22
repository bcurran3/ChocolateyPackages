$packageName = 'dell-update' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.dell.com/FOLDER04998700M/1/Dell-Update-Application_JD7FD_WIN_3.0.0_A00.EXE'
$checksum    = '5EC3E784C507821197A2F23077132FCA57425F3CFCD79DE0AE1689DEF2B43E32'

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
