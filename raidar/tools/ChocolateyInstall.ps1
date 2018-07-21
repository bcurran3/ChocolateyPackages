$packageName  = 'raidar'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://www.downloads.netgear.com/files/GDC/READYNAS-COMMON/RAIDar_6.4.0.exe'
$checksum     = '6CBAD697569802C318731F4CA6D1A0125BFC1E6F4BB63922A3583D75BE599928'
$fileFullPath = "$toolsDir\RAIDar_6.4.0.exe"
$shortcutName = 'RAIDar'
$programEXE   = 'RAIDar.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  fileFullPath  = $fileFullPath
}

Show-Patreon "https://www.patreon.com/bcurran3"  
Get-ChocolateyWebFile @packageArgs
Rename-Item $FileFullpath "RAIDar.exe"

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk" -targetPath "$toolsDir\$programEXE"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -targetPath "$toolsDir\$programEXE"

Show-ToastMessage "$packageName installed." "Version $env:packageVersion."


