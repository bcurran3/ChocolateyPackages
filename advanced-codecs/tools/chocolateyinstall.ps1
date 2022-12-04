# https://shark007.net/files/ADVANCED_64bitCodecs.7z
$ErrorActionPreference = 'Stop';
$packageName  = 'advanced-codecs'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName = 'Shark007''s 64bit ADVANCED Codecs.lnk'

if (Test-Path "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs\Tools\AutoUpdate.exe"){
	Write-Host "  ** Running AutoUpdate." -Foreground Magenta
	Start-ChocolateyProcessAsAdmin -Statements "silent" -ExeToRun "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs\Tools\AutoUpdate.exe" -WorkingDirectory "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs\Tools"
	return
}

$packageArgs = @{
  packageName    = $packageName
  Destination    = "$env:ProgramFiles\Shark007"
  FileFullPath64 = "$toolsDir\ADVANCED_64bitCodecs.7z"
}
Get-ChocolateyUnzip @packageArgs

Start-ChocolateyProcessAsAdmin -Statements "silent" -ExeToRun "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs\Launcher64.exe" -WorkingDirectory "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs"
Start-ChocolateyProcessAsAdmin -Statements "users" -ExeToRun "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs\Tools\Settings64_portable.exe" -WorkingDirectory "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs\Tools\"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs\Launcher64.exe" -RunAsAdmin
Remove-Item "$toolsDir\ADVANCED_64bitCodecs.7z" | Out-Null
