$ErrorActionPreference = 'Stop'
$packageName = 'dell-update' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.dell.com/FOLDER06747853M/1/Dell-Update-Application-for-Windows-10_TKFWF_WIN_4.0.0_A00.EXE'
$checksum    = 'c8b5cec216264aa089bfae268821096c4c551fd030f039d3681b1fc89f96f76f'

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
