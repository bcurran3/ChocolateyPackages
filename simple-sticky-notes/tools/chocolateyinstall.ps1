$ErrorActionPreference = 'Stop'
$packageName    = 'simple-sticky-notes'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\Setup_SimpleStickyNotes.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  validExitCodes = @(0,1)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'Simple Sticky Notes*'
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -force | Out-Null
Remove-Item $toolsDir\*.ignore -force | Out-Null
