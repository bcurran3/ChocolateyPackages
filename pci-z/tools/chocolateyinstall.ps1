$packageName = 'pci-z' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.pci-z.com/current/PCI-Z.zip'
$checksum    = '10CF2525408761B9BE84EA4449D54C6B8234B4A055E598E15D9E9611727DFC07'
$url64       = 'https://www.pci-z.com/current/x64/PCI-Z.zip'
$checksum64  = '217E3FEFF786086BEC79B16D1CC9A463E78811426BFE055190AB6BDD570802B8'



$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\PCI-Z.lnk" -targetPath "$toolsDir\PCI-Z.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PCI-Z.lnk" -targetPath "$toolsDir\PCI-Z.exe"       
