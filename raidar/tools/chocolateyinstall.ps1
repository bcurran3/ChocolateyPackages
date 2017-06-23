$packageName  = 'raidar'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://www.downloads.netgear.com/files/GDC/READYNAS-COMMON/RAIDar_6.3.0.exe'
$checksum     = '18777CD3E2E75D5D355053BB3A81EBB4D84FD2DC45FDD3C5A533C0A359F3AFFE'
$fileFullPath = Join-Path $toolsDir "RAIDar_6.3.0.exe"
$shortcutName = 'RAIDar'
$programEXE   = 'RAIDar_6.3.0.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  fileFullPath  = $fileFullPath
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk" -targetPath "$toolsDir\$programEXE"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -targetPath "$toolsDir\$programEXE"

