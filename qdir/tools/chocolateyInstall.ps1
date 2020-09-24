$ErrorActionPreference = 'Stop'
$packageName    = 'qdir'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$url            = "$toolsDir\Q-Dir_Installer.zip"
$url64          = "$toolsDir\Q-Dir_Installer_x64.zip"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  url64          = $url64
}

Install-ChocolateyZipPackage @packageArgs

if ($bits -eq 64)
   {
    $fileLocation = "$toolsDir\Q-Dir_Installer_x64.exe"
   } else {
    $fileLocation = "$toolsDir\Q-Dir_Installer_UC.exe"
   }
   
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
  file          = $fileLocation
  silentArgs    = '/S langid=1'
  validExitCodes= @(0,1)
  softwareName  = 'Q-Dir'
}
 
Install-ChocolateyInstallPackage @packageArgs

Install-BinFile -Name qdir -Path $env:ProgramFiles\Q-Dir\Q-Dir.exe
Remove-Item "$toolsDir\q*.zip" | Out-Null
