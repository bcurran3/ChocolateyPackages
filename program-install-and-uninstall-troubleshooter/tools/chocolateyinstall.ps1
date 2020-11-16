$ErrorActionPreference = 'Stop'
$packageName = 'program-install-and-uninstall-troubleshooter' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://download.microsoft.com/download/7/E/9/7E9188C0-2511-4B01-8B4E-0A641EC2F600/MicrosoftProgram_Install_and_Uninstall.meta.diagcab'
$checksum    = '8CAD66ADB36B1F4F64204A4328A063AE33695DBBD5386F761CFB56C2C0987471'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  FileFullPath  = "$toolsDir\MicrosoftProgram_Install_and_Uninstall.meta.diagcab"
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\MS Install Uninstall Troubleshooter (Portable).lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\MicrosoftProgram_Install_and_Uninstall.meta.diagcab"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\MS Install Uninstall Troubleshooter (Portable).lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\MicrosoftProgram_Install_and_Uninstall.meta.diagcab"
