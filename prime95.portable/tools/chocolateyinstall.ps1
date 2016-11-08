$ErrorActionPreference = 'Stop'
$packageName  = 'prime95.portable' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.mersenne.org/ftp_root/gimps/p95v289.win32.zip'
$url64        = 'http://www.mersenne.org/ftp_root/gimps/p95v289.win64.zip'
$ExeFile      = 'prime95.exe'
$ShortcutName = 'Prime95'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  url64         = $url64
  checksum      = 'F8C58AB55A2578B243711D3CB1640F62C501AC515E9DC076009AF7E6525D66A4'
  checksumType  = 'sha256' 
  checksum64    = '6DEAA2C6C07FBF0E4259A66ABF56A5E7A69A7623D5AA0803D567D7A75CD513E8'
  checksumType64= 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\$ExeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir"