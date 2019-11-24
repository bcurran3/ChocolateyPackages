$ErrorActionPreference = 'Stop'
$packageName  = 'tageditor' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits         = Get-ProcessorBits
$shortcutName = 'Tag Editor.lnk'
$exeTarget    = "$toolsDir\tageditor.exe"

Remove-Item $exeTarget -Force -ErrorAction SilentlyContinue | Out-Null

Get-ChocolateyUnzip -FileFullPath "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-x86_64-w64-mingw32.zip" -FileFullPath64 "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-i686-w64-mingw32.zip" -Destination $toolsDir

if ($bits -eq 64)
   {
    Rename-Item "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-i686-w64-mingw32.exe" 'tageditor.exe'
   } else {
    Rename-Item "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-x86_64-w64-mingw32.exe" 'tageditor.exe'
   }

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$exeTarget" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$exeTarget" -WorkingDirectory "$toolsDir\"

Remove-Item "$toolsDir\*.zip" -Recurse -Force | Out-Null
