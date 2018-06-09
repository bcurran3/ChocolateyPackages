$packageName    = 'mame' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/mamedev/mame/releases/download/mame0198/mame0198b_32bit.exe'
$checksum       = 'CDFDA3EE21605723EC674FF9DCBDDB4D95F639C701526707819244FAD781D360'
$url64          = 'https://github.com/mamedev/mame/releases/download/mame0198/mame0198b_64bit.exe'
$checksum64     = '9A81FEA6287059A9392FDC9923981F9641C976BE69DA45FE5DDD687C6B8CE5C1'
$bits           = Get-ProcessorBits

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  url64         = $url64
  checksum64    = $checksum64
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

if ($bits -eq 64)
   {
    Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\MAME.lnk" -targetPath "$toolsDir\mame64.exe" -WorkingDirectory "$toolsDir"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\MAME.lnk" -targetPath "$toolsDir\mame64.exe"    
   } else {
    Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\MAME.lnk" -targetPath "$toolsDir\mame.exe" -WorkingDirectory "$toolsDir"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\MAME.lnk" -targetPath "$toolsDir\mame.exe"       
    }

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
  


