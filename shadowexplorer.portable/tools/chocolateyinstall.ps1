$ErrorActionPreference = 'Stop'
$packageName= 'shadowexplorer.portable' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.shadowexplorer.com/uploads/ShadowExplorer-0.9-portable.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip' 
  url           = $url
  checksum      = '92590121920B130A7787C25036D17CF4BD188F1DE7CFAC6D98C254EEF531BB92'
  checksumType  = 'sha256'  
  }

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\ShadowExplorerPortable.lnk" -targetPath "$toolsDir\ShadowExplorerPortable-0.9\ShadowExplorerPortable.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\ShadowExplorerPortable.lnk" -targetPath "$toolsDir\ShadowExplorerPortable-0.9\ShadowExplorerPortable.exe" -WorkingDirectory "$toolsDir"
