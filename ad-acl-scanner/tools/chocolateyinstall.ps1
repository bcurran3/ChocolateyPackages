$ErrorActionPreference = 'Stop'
$packageName  = 'ad-acl-scanner' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://raw.githubusercontent.com/canix1/ADACLScanner/master/ADACLScan.ps1'
$checksum     = 'B51FB4F0F794934C98CEBE9E850957D508BCF2AF1FDCC4F06C12929DBC8D8F85'
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

Install-ChocolateyShortcut -shortcutFilePath "$env:USERPROFILE\Desktop\$shortcutName.lnk" -targetPath $FileFullpath -WorkingDirectory "$toolsDir"

