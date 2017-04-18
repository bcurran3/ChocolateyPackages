#http://us2-dl.techpowerup.com/files/8fWWgOHEaELfS-laFY8IrA/1492513531/GPU-Z.1.20.0.exe

$packageName      = 'gpu-z'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeFile          = "GPU-Z.1.20.0.exe"
$url              = "$toolsDir\GPU-Z.1.20.0.exe"
$checksum         = 'E32C5A4D5D65E32150D51A92D5A09ADD76FD3857BA1F9DB2CFAE55014D3B8184'
$scriptDir        = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
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
