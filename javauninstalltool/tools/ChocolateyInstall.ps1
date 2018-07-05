$ErrorActionPreference = 'Stop'
$packageName  = 'javauninstalltool' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://javadl-esd-secure.oracle.com/update/jut/JavaUninstallTool.exe'
$checksum     = '5AAF337DEAA0E1F5ED8A00C6D2D6EBF98E704A8355D978B2DE8F22526535B0E9'
$FileFullPath = "$toolsDir\JavaUninstallTool.exe"
$shortcutName = 'Java Uninstall Tool.lnk'
$portableEXE  = 'JavaUninstallTool.exe'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $FileFullPath
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
}
 
Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"