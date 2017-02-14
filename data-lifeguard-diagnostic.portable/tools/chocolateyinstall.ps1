$ErrorActionPreference = 'Stop'
$packageName = 'data-lifeguard-diagnostic.portable'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://downloads.wdc.com/windlg/WinDlg_v1_31.zip'
 
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = '799E9F425100377B47671CBA05A5EC2EA26C79786A3D718E23DAFF4CE27A023A'
  checksumType  = 'sha256'  
}
 
Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Data Lifeguard Diagnostic for Windows.lnk" -targetPath "$toolsDir\WinDlg.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Data Lifeguard Diagnostic for Windows.lnk" -targetPath "$toolsDir\WinDlg.exe"