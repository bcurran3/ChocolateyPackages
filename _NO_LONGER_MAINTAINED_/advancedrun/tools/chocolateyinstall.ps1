$ErrorActionPreference = 'Stop'
$packageName  = 'advancedrun' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName = 'AdvancedRun.lnk'
$exe          = 'AdvancedRun.exe'

$packageArgs = @{
  packageName    = $packageName
  Destination    = $toolsDir
  FileFullPath   = "$toolsDir\advancedrun.zip"
  FileFullPath64 = "$toolsDir\advancedrun-x64.zip"
}

Get-ChocolateyUnzip @packageArgs
Remove-Item "$toolsDir\*.zip" -EA SilentlyContinue | Out-Null

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe"    
