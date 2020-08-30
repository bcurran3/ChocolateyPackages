$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-automation-manager'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "https://rm-downloads-us.logicnow.com/automation-manager/AutomationManager-$env:ChocolateyPackageVersion.exe"
$checksum       = '7756B2836C1AAC85B1EF012BC95FAEAA92AA9429671C4DC2B31B33D46DF552BE'

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

