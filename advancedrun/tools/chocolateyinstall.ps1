$ErrorActionPreference = 'Stop'
$packageName  = 'advancedrun' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.nirsoft.net/utils/advancedrun.zip'
$checksum     = '1826158A41EDE17BC4A0736A22EC68C2F18FAED3839CE04BAFDC7B19D5E853EE'
$url64        = 'http://www.nirsoft.net/utils/advancedrun-x64.zip'
$checksum64   = '34743C6E9E940B2CD7A65447E2B0A9A033CF3BA0027BAD1929948A427CE4FB83'
$shortcutName = 'AdvancedRun.lnk'
$exe          = 'AdvancedRun.exe'

$packageArgs = @{
  packageName    = $packageName
  Destination    = $toolsDir
  FileFullPath   = "$toolsDir\advancedrun.zip"
  FileFullPath64 = "$toolsDir\advancedrun-x64.zip"
}

Get-ChocolateyUnzip @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe"
Remove-Item "$toolsDir\*.zip" -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.ignore" -ErrorAction SilentlyContinue | Out-Null
