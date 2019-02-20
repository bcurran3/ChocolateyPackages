$ErrorActionPreference = 'Stop'
$packageName= 'cobian-backup' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = "$toolsDir\cbSetup.exe"
  validExitCodes= @(0)
  silentArgs    = "ini=$toolsDir\cbSetup.txt"
  softwareName  = 'Cobian Backup 11 Gravity*'
}

Install-ChocolateyInstallPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\Cobian Backup 11.lnk" -targetPath "C:\Program Files\Cobian Backup 11\Cobian.exe" -WorkingDirectory "C:\Program Files\Cobian Backup 11\"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Cobian Backup 11.lnk" -targetPath "C:\Program Files\Cobian Backup 11\Cobian.exe" -WorkingDirectory "C:\Program Files\Cobian Backup 11\"
