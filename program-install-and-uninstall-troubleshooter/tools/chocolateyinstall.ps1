$packageName= 'program-install-and-uninstall-troubleshooter' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/7/E/9/7E9188C0-2511-4B01-8B4E-0A641EC2F600/MicrosoftProgram_Install_and_Uninstall.meta.diagcab'
$FileFullPath = Join-Path $toolsDir 'MicrosoftProgram_Install_and_Uninstall.meta.diagcab'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  FileFullPath  = $FileFullPath
  url           = $url
  checksum      = 'B7712D302092E2B08A63E6B15A423EBB4E96E1804B9FEEF15F52979B37812E0C'
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\MS Install Uninstall Troubleshooter (Portable).lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\MicrosoftProgram_Install_and_Uninstall.meta.diagcab"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\MS Install Uninstall Troubleshooter (Portable).lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\MicrosoftProgram_Install_and_Uninstall.meta.diagcab"
