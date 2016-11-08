$ErrorActionPreference = 'Stop'
$packageName= 'xboot' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://sites.google.com/site/shamurxboot/XBootv1.0beta14.zip'
$url64      = $url
$ExeFile = 'xbootvs1.0beta14.exe'
$ShortcutName = 'XBoot'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  url64bit      = $url
  checksum      = 'CF6AA1245817F5BB1491A06AD3A76E33844C0D155F227CDA2BAE3E36F70B5E04'
  checksumType  = 'sha256' 
  checksum64    = 'CF6AA1245817F5BB1491A06AD3A76E33844C0D155F227CDA2BAE3E36F70B5E04'
  checksumType64= 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\$ExeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir"