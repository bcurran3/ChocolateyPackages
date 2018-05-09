$packageName   = 'mrboom' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/Javanaise/mrboom-libretro/releases/download/4.5/MrBoom-win64-4.5.zip'
$checksum      = '6DF7ADE14EEF3443679A15165AD7762799C826ED224E08AF1241F6D0F20A8483'
$PortableEXE   = 'MrBoom.exe'
$ShortcutName  = 'MrBoom.lnk'
$bits          = Get-ProcessorBits

if ($bits -eq 32)
   {
	Write-Host "MrBoom is 64 bit Windows only. Aborting..." -foreground red -backgroundcolor blue
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
