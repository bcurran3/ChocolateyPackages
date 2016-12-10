$ErrorActionPreference = 'Stop'
$packageName      ='gpu-z'
$url              = 'http://us3-dl.techpowerup.com/SysInfo/GPU-Z/GPU-Z.1.14.0.exe' 
$checksum         = '3736EFCFF7B1C7AC541C20899C70603AA7F6DB74ED8AAA4532AE7128D051729D'
$exeFile          = "GPU-Z.1.11.0.exe"
$scriptDir        = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$installerPackage = Join-Path $scriptDir $exeFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $installerPackage
  softwareName  = 'GPU*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\GPU-Z.lnk" -targetPath "$env:ChocolateyInstall\lib\gpu-z\tools\$exeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\$exeFile"
