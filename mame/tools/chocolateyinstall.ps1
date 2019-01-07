$packageName    = 'mame' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/mamedev/mame/releases/download/mame0205/mame0205b_32bit.exe'
$checksum       = '2455E0AD52D2AB0157B486981B4F85759BDD7E25CC396718DEC513D414EB820C'
$url64          = 'https://github.com/mamedev/mame/releases/download/mame0205/mame0205b_64bit.exe'
$checksum64     = '1DB53EF75BD6629A8CFA32AFAC8ACDC71D0D2702163E38F11C4924B8C3025E2A'
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
  


