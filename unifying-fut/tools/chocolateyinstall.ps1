$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://aws13-customer-care-assets.s3.amazonaws.com/Software/SecureDFU/Win/SecureDFU_48.exe'
$checksum = 'D0E7DF9F19AC7DD2BA3976995ED2461C5DC296D0E5DCB65C17DAD46AACAD44C0'
$exe      = 'SecureDFU_48.exe'
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
