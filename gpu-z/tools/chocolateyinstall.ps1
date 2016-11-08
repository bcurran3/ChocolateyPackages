$ErrorActionPreference = 'Stop'
$packageName='gpu-z'
$url        = 'http://us3-dl.techpowerup.com/SysInfo/GPU-Z/GPU-Z.1.12.0.exe' 
$exeFile    = "GPU-Z.1.11.0.exe"
$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$installerPackage = Join-Path $scriptDir $exeFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $installerPackage
  softwareName  = 'GPU*'
  checksum      = 'F564EB1B1E7AB2362F0FCE6D42B9AE7159F4855B85E5CB0B0DB3763E87C7AEB2'
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\GPU-Z.lnk" -targetPath "$env:ChocolateyInstall\lib\gpu-z\tools\$exeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\$exeFile"
