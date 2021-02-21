$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName = 'HBBatchBeast.lnk'
$exe          = 'hbbatchbeast.exe'

$packageArgs = @{
  packageName    = 'hbbatchbeast'
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  file           = "$toolsDir\hbbatchbeast-Windows-"+"$env:ChocolateyPackageVersion"+".7z"
  }

Install-ChocolateyZipPackage @packageArgs	

Remove-Item $toolsDir\*.zip -EA SilentlyContinue | Out-Null

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
