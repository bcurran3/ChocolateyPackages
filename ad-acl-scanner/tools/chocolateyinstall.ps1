$ErrorActionPreference = 'Stop'
$packageName  = 'ad-acl-scanner' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://raw.githubusercontent.com/canix1/ADACLScanner/master/ADACLScan.ps1'
$checksum     = '59E95375E1C243FADEAB5E52F941AF1BD2926D94135EB4A712E5C3029D0AD9EC'
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

