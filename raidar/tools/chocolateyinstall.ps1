$ErrorActionPreference = 'Stop'
$packageName  ='raidar'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://readycloud.netgear.com/client/install/RAIDar.exe'
$fileFullPath =Join-Path $toolsDir "RAIDar.exe"
$shortcutName ='RAIDar'
$programEXE   ='RAIDar.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = 'E2AB2636DB74370B1F4D708F8E43BBF2E887D08A39DF5C99EAE51DA978FDCCDC'
  checksumType  = 'sha256'
  fileFullPath  = $fileFullPath
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk" -targetPath "$toolsDir\$programEXE"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -targetPath "$toolsDir\$programEXE"

