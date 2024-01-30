$ErrorActionPreference = 'Stop'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = 'flicflac'

if (Test-Path "$toolsDir\FlicFlac.exe") {Remove-Item "$toolsDir\FlicFlac.exe"}

$packageArgs = @{
  packageName    = $packageName
  Destination    = $toolsDir
  FileFullPath   = "$toolsDir\flicflac.zip"
}

Get-ChocolateyUnzip @packageArgs

New-Item "$toolsDir\FlicFlac.exe.ignore" -Force -ItemType file
Remove-Item "$toolsDir\*.zip" -EA SilentlyContinue | Out-Null
Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\FlicFlac.lnk" -targetPath "$ENV:ChocolateyInstall\lib\flicflac\tools\FlicFlac.exe"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\FlicFlac.lnk" -targetPath "$toolsDir\FlicFlac.exe"    

# UPDATE INSTRUCTIONS
# Replace ZIP file