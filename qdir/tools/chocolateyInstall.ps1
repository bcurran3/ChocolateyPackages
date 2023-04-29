$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName 
  Destination    = $toolsDir
  FileFullPath   = "$toolsDir\Q-Dir_Installer.zip"
  FileFullPath64 = "$toolsDir\Q-Dir_Installer_x64.zip"
}
Get-ChocolateyUnzip @packageArgs
   
$langid=(Get-Culture).LCID
# Probably best to match .EnglishName to cover various countries with same language but different layout instead of culture ID
################# or use .parent.name
# GERMAN=0
# ENGLISH=1 1033, 4105, 
# FRENCH=2
# THAI = 5
# JAPANESE = 6
# KOREAN = 7
# POLISH = 8
# CHINESE = 9
# ITALIAN = 3
# RUSSIAN = 10
# DUTCH = 11
# TURKISH = 12
# GREEK = 13
# SPANISH = 14
# SLOVAK = 15
# CZECH = 16
# DANISH = 17
# PROTUGUESE = 18
# ROMANIAN = 19
# CROATIAN - 23
# SLOVENIAN = 24
# FINISH = 21
# ARABIC = 25 1
# HUNGARIAN = 22
# UKRAINIAN = 26

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = "$toolsDir\Q-Dir_Installer_UC.exe"
  file64        = "$toolsDir\Q-Dir_Installer_x64.exe"
  silentArgs    = '/S langid=1'
  validExitCodes= @(0,1)
  softwareName  = 'Q-Dir'
}
 
Install-ChocolateyInstallPackage @packageArgs

Install-BinFile -Name qdir -Path $env:ProgramFiles\Q-Dir\Q-Dir.exe
Remove-Item "$toolsDir\q*.zip" | Out-Null
Remove-Item "$toolsDir\q*.exe" | Out-Null

# UPDATE INSTRUCTIONS:
# Replace ZIPS with new versions
