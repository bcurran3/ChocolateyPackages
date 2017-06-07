$ErrorActionPreference = 'Stop'
$packageName  = 'lan-messenger.portable' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/lanmessenger/lanmessenger/releases/download/v1.2.37/lmc-1.2.37-win32.zip'
$checksum     = '3867D3B96CA207FE265B727390B19D9044DD0019EC2E26DC8534E1FEC8D4AEB6'
$ShortcutName = 'LAN Messenger'
$exe          = 'lmc.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  }

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"