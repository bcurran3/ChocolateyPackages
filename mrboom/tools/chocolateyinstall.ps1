$packageName   = 'mrboom' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/Javanaise/mrboom-libretro/releases/download/4.1/MrBoom-win64-4.1.zip'
$checksum      = '443E0493F89CD367B5E3347FE198EFC1EEBE26F709758104D647F1E2A9364EA5'
$PortableEXE   = 'MrBoom.exe'
$ShortcutName  = 'MrBoom.lnk'
$bits          = Get-ProcessorBits

if ($bits -eq 32)
   {
	Write-Host "MrBoom is 64 bit only. Aborting." -foreground red -backgroundcolor blue
	throw
   } else {
   }

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum 
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$PortableEXE" -WorkingDirectory "$toolsDir\$packageName" -iconLocation "$toolsDir\mrboom.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$PortableEXE" -WorkingDirectory "$toolsDir\$packageName" -iconLocation "$toolsDir\mrboom.ico"
