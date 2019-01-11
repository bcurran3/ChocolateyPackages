$ErrorActionPreference = 'Stop'
$packageName  = 'taskschedulerview' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName = 'TaskSchedulerView.lnk'
$exe          = 'TaskSchedulerView.exe'

$packageArgs = @{
  packageName    = $packageName
  Destination    = $toolsDir
  FileFullPath   = "$toolsDir\taskschedulerview.zip"
  FileFullPath64 = "$toolsDir\taskschedulerview-x64.zip"
}

Get-ChocolateyUnzip @packageArgs
Remove-Item "$toolsDir\*.zip" | out-null

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe"    
