$ErrorActionPreference = 'Stop'
$packageName  = 'tageditor' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits         = Get-ProcessorBits
$shortcutName = 'Tag Editor.lnk'
$exeTarget    = "tageditor.exe"

Remove-Item "$toolsDir\*.exe" -Force -ErrorAction SilentlyContinue | Out-Null

Get-ChocolateyUnzip -FileFullPath "$toolsDir\*.zip" -Destination $toolsDir

if ($bits -eq 64)
   {
    Rename-Item "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-i686-w64-mingw32.exe" 'tageditor.exe'
	Remove-Item "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-x86_64-w64-mingw32.exe"
   } else {
    Rename-Item "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-x86_64-w64-mingw32.exe" 'tageditor.exe'
	Rename-Item "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-i686-w64-mingw32.exe"
   }

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exeTarget" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exeTarget" -WorkingDirectory "$toolsDir\"

Remove-Item "$toolsDir\*.zip" -Force -ErrorAction SilentlyContinue
