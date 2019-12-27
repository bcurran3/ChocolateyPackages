$ErrorActionPreference = 'Stop'
$packageName    = 'irfanviewplugins'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysVersion  = ($env:ChocolateyPackageVersion -replace '[.]','')
$url            = "$toolsDir\iview"+$TodaysVersion+"_plugins_setup.exe"
$url64          = "$toolsDir\iview"+$TodaysVersion+"_plugins_x64_setup.exe"
					  
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  file64         = $url64
  validExitCodes = @(0)
  silentArgs     = '/silent'
  softwareName   = ''
}

Install-ChocolateyInstallPackage @packageArgs  

Remove-Item $url -EA SilentlyContinue | Out-Null
Remove-Item $url64 -EA SilentlyContinue | Out-Null
