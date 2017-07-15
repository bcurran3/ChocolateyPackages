$ErrorActionPreference = 'Stop'
$packageName  = 'bulk-ad-users' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.wisesoft.co.uk/Products/BulkADUsers/Download/WiseSoftBulkADUsers_1.0BETA2.zip'
$checksum     = '8A1CA15810FF60AA367276FD1368D984AB2E739A78F93EE612C711858348D14F'
$shortcutName = 'Bulk AD Users.lnk'
$exe          = 'BulkADUsers.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}


Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"