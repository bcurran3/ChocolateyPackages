$ErrorActionPreference = 'Stop'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName   = 'xmedia-recode'
$TodaysVersion = ($ENV:ChocolateyPackageVersion -replace '[.]','')
$url           = "$toolsDir\XMediaRecode"+$TodaysVersion+"_setup.exe"
$url64         = "$toolsDir\XMediaRecode"+$TodaysVersion+"_x64_setup.exe"
 
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  file64         = $url64
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $url | Out-Null
Remove-Item $url64 | Out-Null
