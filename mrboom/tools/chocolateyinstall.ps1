$packageName   = 'mrboom' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/Javanaise/mrboom-libretro/releases/download/3.7/MrBoom-win64-3.7.zip'
$checksum      = '6F17D2967CFD1DD905B97E2C5A01F78B3E85E4E7A5472D4E267AFCA3C811A8ED'
$ExeFile       = 'MrBoom.exe'
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

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName" -iconLocation "$toolsDir\mrboom.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName" -iconLocation "$toolsDir\mrboom.ico"
