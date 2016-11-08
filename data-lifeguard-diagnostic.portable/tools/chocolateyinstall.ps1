$ErrorActionPreference = 'Stop'
$packageName= 'data-lifeguard-diagnostic.portable'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.wdc.com/windlg/WinDlg_v1_29.zip'
 
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = '323B779033A609F1F6A7A849CCF7D2D4041549101FC51019EACC877EAFED99D3'
  checksumType  = 'sha256'  
}
 
Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Data Lifeguard Diagnostic for Windows.lnk" -targetPath "$toolsDir\WinDlg.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Data Lifeguard Diagnostic for Windows.lnk" -targetPath "$toolsDir\WinDlg.exe"