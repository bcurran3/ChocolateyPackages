$ErrorActionPreference = 'Stop'
$packageName = 'dell-update' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.dell.com/FOLDER08911281M/1/Dell-Update-Alienware-Update-Application_3T5JX_WIN_4.6.0_A00.EXE'
$checksum    = '60C9EE7FDED2056ACA0A51E5FC04CAC9572B146D4816EE1913D96EC36BF3CA9B'

Confirm-Win10

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

