$ErrorActionPreference = 'Stop'
$packageName = 'dell-update' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.dell.com/FOLDER09523896M/1/Dell-Update-Windows-Universal-Application_0RCG0_WIN_4.8.0_A00.EXE?uid=8d6690be-eddc-4b75-e9ab-fb7670b153c3&fn=Dell-Update-Windows-Universal-Application_0RCG0_WIN_4.8.0_A00.EXE'
$checksum    = '4B09CD47E12745743F24F8878C800D1E106550B69113801CFAF1E2B78D9AB1E4'

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

