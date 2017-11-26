$packageName    = 'mame' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/mamedev/mame/releases/download/mame0191/mame0191b_32bit.exe'
$checksum       = '579BF48B3FF42AEB6D319B2A6978A313EF213BE605A7CA94F7AE2794AF76F9F7'
$url64          = 'https://github.com/mamedev/mame/releases/download/mame0191/mame0191b_64bit.exe'
$checksum64     = '20DDB06B21776913FC5631BF8CEB823FBE0ADE79FF864FD83152CED17355AAE0'
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
  


