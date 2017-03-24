#http://us2-dl.techpowerup.com/files/eCkLKAGjgHgutFGViLjHAg/1490377969/GPU-Z.1.18.0.exe

$packageName      = 'gpu-z'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = "$toolsDir\GPU-Z.1.18.0.exe"
$checksum         = '73AA057194D35FF17025B3B5018D2DFEBE48C9E3E31CC4587AD8988FA6C4B881'
$scriptDir        = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$exeFile          = "GPU-Z.1.18.0.exe"
$installerPackage = Join-Path $scriptDir $ExeFile

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
