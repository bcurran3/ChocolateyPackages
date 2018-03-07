$packageName   = 'mrboom' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/Javanaise/mrboom-libretro/releases/download/4.4/MrBoom-win64-4.4.zip'
$checksum      = 'A0999BBCF93B2465A9178E79C32DC6ECF8FE3742B9E82AB2718E089360E21AA6'
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
