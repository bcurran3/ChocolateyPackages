$ErrorActionPreference = 'Stop'
$packageName = 'dell-update' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.dell.com/FOLDER09268420M/1/Dell-Update-Windows-Universal-Application_0991N_WIN_4.7.1_A00.EXE?uid=351dc1fb-478e-4ac6-96c1-60aaa7f8012c&fn=Dell-Update-Windows-Universal-Application_0991N_WIN_4.7.1_A00.EXE'
$checksum    = '532b68372ce7d6ae80ac17fca2ab5d4d2c435276eaff270269075361894faab5'

Confirm-Win10

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/s'
  validExitCodes= @(0,2)
  softwareName  = 'Dell Update' 
}

Install-ChocolateyPackage @packageArgs

