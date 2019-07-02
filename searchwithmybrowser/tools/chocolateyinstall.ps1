$ErrorActionPreference = 'Stop'
$packageName   = 'searchwithmybrowser'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = "$toolsDir\SWMB-setup.exe"
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
  softwareName  = 'SearchWithMyBrowser*' 
}
 
Install-ChocolateyInstallPackage @packageArgs
