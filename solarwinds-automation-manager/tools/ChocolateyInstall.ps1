$packageName    = 'solarwinds-automation-manager'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://rm-downloads-us.logicnow.com/automation-manager/AutomationManager-2.4.0.43.exe'
$checksum       = '268D35CD2E2CF269C4D2DBC2276DA6DF2F2B0227A966C4581F4EEE3EDCF2F5B1'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0,1)
  silentArgs    = '/S'
  softwareName  = 'Automation Manager*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

