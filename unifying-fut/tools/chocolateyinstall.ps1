$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://download01.logi.com/web/ftp/pub/techsupport/keyboards/FirmwareUpdateTool_2.6.201219_x86.exe'
$checksum = '38BCA469FF6418ADDD22A4AFFAB9F15BF96C2CE704CFC9D0A2AB51307A29F888'
$exe      = 'FirmwareUpdateTool_2.6.201219_x86.exe'
$shortcutName = 'Logitech Firmware Update Tool.lnk'


$packageArgs = @{
    packageName    = 'unifying-fut'
    url            = $url
    checkum        = $checksum
    checksumType   = 'sha256'
    fileType       = 'EXE'
    FileFullPath   = "$toolsDir\$exe"
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
