$ErrorActionPreference = 'Stop'
$packageName= 'game-key-revealer.portable' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://sites.google.com/site/cakirbey/GameKeyRevealer.zip'
$url64      = $url
$ExeFile = 'GameKeyRevealer.exe'
$ShortcutName = 'Game Key Revealer'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = '9B31CA62F666D7791DDBEAF827E8D43F38324BC19EC03323A0F037153F142745'
  checksumType  = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\$ExeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir"