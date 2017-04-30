$packageName    = 'mame' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/mamedev/mame/releases/download/mame0185/mame0185b_32bit.exe'
$checksum       = 'FEA15C076D7FC1DF86EF09370755B999F1250D2C9C6F3399BC4198804B28B755'
$url64          = 'https://github.com/mamedev/mame/releases/download/mame0185/mame0185b_64bit.exe'
$checksum64     = '9E38B586B58393796DCD551E4BC5AD2752F9834BDBA5677298B2C21220864F5B'
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
  


