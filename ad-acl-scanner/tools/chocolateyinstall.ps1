$ErrorActionPreference = 'Stop'
$packageName  = 'ad-acl-scanner' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://raw.githubusercontent.com/canix1/ADACLScanner/master/ADACLScan.ps1'
$checksum     = '908819F1E2BAAC1B8BDBDB58C4DA7325606173555E1188CBEE22D54E2A3D612A'
$fileName     = 'ADACLScan.ps1'
$shortcutName = 'AD ACL Scanner' 
$FileFullpath = Join-Path $ToolsDir $fileName


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

