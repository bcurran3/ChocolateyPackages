$ErrorActionPreference = 'Stop'
$packageName = 'allway-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://allwaysync.com/content/download/allwaysync.exe'
$checksum    = 'E7549AB6A57A8453C0AB35A5F874436A661151D28A7D33BCC1FBFAB30064529B'
$url64       = 'https://allwaysync.com/content/download/allwaysync-x64.exe'
$checksum64  = '5E6FAF4E74759242ED6C92D852123FBCDB019DCCD3BF0D2B15F3EF687B245C24'
$silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName  = 'Allway Sync*' 
  }
  
Install-ChocolateyPackage @packageArgs
