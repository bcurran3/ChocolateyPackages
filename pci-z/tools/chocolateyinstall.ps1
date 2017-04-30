$packageName = 'pci-z' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.pci-z.com/current/PCI-Z.zip'
$checksum    = '7E848A81C6CDCC5E47A54317BC27A2007F04E4AC4A0CB6481935DD2CD0192869'
$url64       = 'https://www.pci-z.com/current/PCI-Zx64.zip'
$checksum64  = '5F2F9D05C87B667EBB9036A216F2574D91CE3BB9AC5DA1167A1AF0942820AB84'
$bits = Get-ProcessorBits


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

if ($bits -eq 64)
   {
    Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\PCI-Z.lnk" -targetPath "$toolsDir\PCI-Zx64.exe" -WorkingDirectory "$toolsDir"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PCI-Z.lnk" -targetPath "$toolsDir\PCI-Zx64.exe"    
   } else {
    Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\PCI-Z.lnk" -targetPath "$toolsDir\PCI-Z.exe" -WorkingDirectory "$toolsDir"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PCI-Z.lnk" -targetPath "$toolsDir\PCI-Z.exe"       
    }