$ErrorActionPreference = 'Stop'
$packageName  = 'ad-acl-scanner' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://raw.githubusercontent.com/canix1/ADACLScanner/master/ADACLScan.ps1'
$checksum     = '534D84F4B46F63DAE278938873787BCA63CF8A2E1C9BFE3168C8DD06C6572D76'
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

