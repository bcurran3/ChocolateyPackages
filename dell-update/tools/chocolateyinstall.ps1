$ErrorActionPreference = 'Stop'
$packageName = 'dell-update' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.dell.com/FOLDER07414870M/1/Dell-Update-Alienware-Update-Application-for-Windows_GRJVD_WIN_4.2.1_A00.EXE'
$checksum    = '0050DFAD0869CD7A4C52F68282B28507F7AD175B18A8CE9E68BF63621B3978D9'

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
