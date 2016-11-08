$ErrorActionPreference = 'Stop'
$packageName= 'moose.portable' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.rusticrhino.com/drlovegrove/Moose077.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = '094D59BC3D100A725DE23E8BBEA03C6E7A61D112E15F5F7C033B2B00AFA8DA00'
  checksumType  = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Moose.lnk" -targetPath "$toolsDir\Moose.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Moose.lnk" -targetPath "$toolsDir\Moose.exe" -WorkingDirectory "$toolsDir"