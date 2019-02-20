$ErrorActionPreference = 'Stop'
$packageName  = 'tageditor' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits         = Get-ProcessorBits
$shortcutName = 'Tag Editor.lnk'

if ($bits -eq 64)
   {
    $exeTarget = "$toolsDir\i686-w64-mingw32\bin\tageditor.exe"
	Remove-Item "$toolsDir\x86_64-w64-mingw32" -Recurse -Force
   } else {
    $exeTarget = "$toolsDir\x86_64-w64-mingw32\bin\tageditor.exe"
	Remove-Item "$toolsDir\i686-w64-mingw32" -Recurse -Force
   }

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$exeTarget" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$exeTarget" -WorkingDirectory "$toolsDir\"   
