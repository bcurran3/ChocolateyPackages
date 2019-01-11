$packageName    = 'visualbasic6-kb896559'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\visualbasic6-kb896559_install.ahk"
$url            = 'https://download.microsoft.com/download/3/a/5/3a5925ac-e779-4b1c-bb01-af67dc2f96fc/VisualBasic6-KB896559-v1-ENU.exe'
$checksum       = 'C4D43FE4AEA782D7D6C08C038778FE3635C7BAE1B93FB1A7740C6644AABF567E'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0,1)
  silentArgs    = '/Q'
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
}

Start-Process $ahkExe $ahkFile  
Install-ChocolateyPackage @packageArgs
