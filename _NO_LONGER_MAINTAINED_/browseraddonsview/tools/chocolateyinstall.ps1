$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = "$toolsDir\browseraddonsview.zip"
$url64        = "$toolsDir\browseraddonsview-x64.zip"
$shortcutName = 'BrowserAddonsView.lnk'
$exe          = 'BrowserAddonsView.exe'

$packageArgs = @{
  packageName    = 'browseraddonsview'
  softwareName   = ''
  fileType       = 'ZIP'
  UnzipLocation  = "$toolsDir"
  silentArgs     = ''
  file           = $url
  file64         = $url64
  validExitCodes = @(0)
  }

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe"    
Remove-Item $toolsDir\*.zip -Force | Out-Null
