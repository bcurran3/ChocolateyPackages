$ErrorActionPreference = 'Stop'
$packageName       = 'adwcleaner' 
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://downloads.malwarebytes.com/file/adwcleaner'
$checksum          = '5D1533CB1BA3516EBADC19E070A3D883A186FB6DAA0F2DABB3559B7E766617E2'
$shortcutName      = 'AdwCleaner.lnk'
$portableEXE       = "adwcleaner_$ENV:packageVersion.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = "$toolsDir\$portableEXE"
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
}
 
Get-ChocolateyWebFile @packageArgs

Install-BinFile -Name adwcleaner -Path "$toolsDir\$portableEXE"

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"

Remove-Item $toolsDir\*.exe -Exclude "adwcleaner_$ENV:packageVersion.exe" | Out-Null #del old vers
Remove-Item $ENV:ChocolateyInstall\bin\adwcleaner_*.exe  | Out-Null #del old vers' shims
