$ErrorActionPreference = 'Stop'
$packageName   = 'mrboom' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/Javanaise/mrboom-libretro/releases/download/4.7/MrBoom-win64-4.7.zip'
$checksum      = '13B64AE7B4BD03AB1CE3807B8F3B6098E94BBEDE24F5224E85FE201A5C3B627A'
$PortableEXE   = 'MrBoom.exe'
$ShortcutName  = 'MrBoom.lnk'
$bits          = Get-ProcessorBits

if ($bits -eq 32)
   {
	Write-Warning "  ** MrBoom is 64 bit Windows only. Aborting..."
	throw
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
