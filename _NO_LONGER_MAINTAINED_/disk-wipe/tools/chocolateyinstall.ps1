$ErrorActionPreference = 'Stop'

$toolsDir   = Split-Path -parent $MyInvocation.MyCommand.Definition
$fileLocation = (Get-ChildItem -Path $toolsDir -filter '*.exe' |
                        Sort-Object lastwritetime | Select-Object -Last 1).FullName

# Create a Start Menu item for all users
$ShortcutArgs = @{
   shortcutFilePath = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\DiskWipe.lnk"
   targetPath       = $fileLocation
   WorkingDirectory = $toolsDir
}
Install-ChocolateyShortcut @ShortcutArgs 

$ShortcutArgs.shortcutFilePath = "$env:Public\Desktop\DiskWipe.lnk"
Install-ChocolateyShortcut @ShortcutArgs 

