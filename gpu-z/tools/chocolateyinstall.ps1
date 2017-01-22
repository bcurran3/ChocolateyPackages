$ErrorActionPreference = 'Stop'
$packageName      ='gpu-z'
$url              = 'http://us2-dl.techpowerup.com/dl/SysInfo/GPU-Z/GPU-Z.1.16.0.exe' 
$checksum         = 'BB4369A75D65728C581BF54566EA6F96F3395B5D7A8BEED74EA5C3CC9A806B02'
$exeFile          = "GPU-Z.1.16.0.exe"
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
