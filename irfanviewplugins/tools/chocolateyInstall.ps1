$ErrorActionPreference = 'Stop'
$packageName    = 'irfanviewplugins'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysVersion  = ($env:ChocolateyPackageVersion -replace '[.]','')
					  
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
#  file           = "$toolsDir\iview"+$TodaysVersion+"_plugins_setup.exe"
  file           = "$toolsDir\iview457_plugins_setup.exe"
#  file64         = "$toolsDir\iview"+$TodaysVersion+"_plugins_x64_setup.exe"
  file64         = "$toolsDir\iview457_plugins_x64_setup.exe"
  validExitCodes = @(0)
  silentArgs     = '/silent'
  softwareName   = ''
}

Install-ChocolateyInstallPackage @packageArgs  

Remove-Item "toolsDir\*.exe" -EA SilentlyContinue | Out-Null
