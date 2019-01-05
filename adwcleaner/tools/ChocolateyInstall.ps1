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

Remove-Item $toolsDir\*.exe -Exclude "adwcleaner_$env:packageVersion.exe" # deleted old versions kept by upgrade
Remove-Item $ENV:ChocolateyInstall\bin\adwcleaner_*.exe # delete shims from previous packages
Remove-Item $toolsDir\*.ignore -Exclude "adwcleaner_$env:packageVersion.exe.ignore" # delete old .ignore files (7.2.8.0+)
Write-Host "" | Out-File "$toolsDir\adwcleaner_$env:packageVersion.exe.ignore" # create .ignore file so shim isn't created
Install-BinFile -Name adwcleaner -Path "$toolsDir\$portableEXE" # create adwcleaner shim instead of adwcleaner_version shim

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"

# Change this to just rename current ver to adwcleaner so i don't have to make a shim