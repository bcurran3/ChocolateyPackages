$ErrorActionPreference = 'Stop'
$packageName       = 'adwcleaner' 
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://downloads.malwarebytes.com/file/adwcleaner'
$checksum          = '8E75E3F6EAFBEA3C775DFBFD1C61DCB699E69E05265DB6F295777B291F530E19'
$shortcutName      = 'AdwCleaner.lnk'
$portableEXE       = "adwcleaner_$env:packageVersion.exe"

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

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"

Remove-Item $toolsDir\*.exe -Exclude "adwcleaner_$env:packageVersion.exe" | Out-Null