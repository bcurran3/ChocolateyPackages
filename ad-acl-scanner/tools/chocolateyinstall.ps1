$ErrorActionPreference = 'Stop'
$packageName  = 'ad-acl-scanner' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://raw.githubusercontent.com/canix1/ADACLScanner/master/ADACLScan.ps1'
$checksum     = '55CB7745DB9B5B5CC0E74E7294A5847A49180D96B0A235EED0B7C6D323800905'
$fileName     = 'ADACLScan.ps1'
$shortcutName = 'AD ACL Scanner' 
$FileFullpath = "$toolsDir\$fileName"


$packageArgs = @{
  packageName   = $packageName
  fileType      = ''
  url           = $url
  FileFullPath  = $FileFullpath
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:USERPROFILE\Desktop\$shortcutName.lnk" -targetPath $FileFullpath -WorkingDirectory "$toolsDir"

