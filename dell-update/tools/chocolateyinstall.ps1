$ErrorActionPreference = 'Stop'
$packageName = 'dell-update' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.dell.com/FOLDER06986434M/1/Dell-Update-Application-for-Windows-10_7CKK6_WIN_4.1.0_A00.EXE'
$checksum    = 'b0d5c1735d0d771917d7cb76422d1c7391ce68cbc57baca4360848c14e9353f7'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/s /f'
  validExitCodes= @(0,2)
  softwareName  = 'Dell Update' 
}

Install-ChocolateyPackage @packageArgs
