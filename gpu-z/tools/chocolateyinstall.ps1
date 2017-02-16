$ErrorActionPreference = 'Stop'
$packageName      ='gpu-z'
#http://us2-dl.techpowerup.com/files/bPHdSWiAQa4191OO9onywQ/1487242612/GPU-Z.1.17.0.exe
$url              = "$toolsDir\GPU-Z.1.17.0.exe"
$checksum         = '7C94B376E592745185D2EA47491A219936F108CB1990818F815F7457AC3F4F26'
$exeFile          = "GPU-Z.1.17.0.exe"
$scriptDir        = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$installerPackage = Join-Path $scriptDir $exeFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= ''
  silentArgs    = ''
  FileFullPath  = $installerPackage
  softwareName  = 'GPU*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs 	

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\GPU-Z.lnk" -targetPath "$env:ChocolateyInstall\lib\gpu-z\tools\$exeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\$exeFile"

Remove-Item $url 