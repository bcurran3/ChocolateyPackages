$ErrorActionPreference = 'Stop'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName   = 'xmedia-recode'
$TodaysVersion = ($ENV:ChocolateyPackageVersion -replace '[.]','')
$url           = "$toolsDir\XMediaRecode"+$TodaysVersion+"_setup.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
