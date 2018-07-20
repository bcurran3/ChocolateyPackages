$packageName    = 'mame' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/mamedev/mame/releases/download/mame0199/mame0199b_32bit.exe'
$checksum       = 'BFDC7569054969F2EB3E39403E6268A187FA6B55E0F8D4CDE4FE886BD459AA6D'
$url64          = 'https://github.com/mamedev/mame/releases/download/mame0199/mame0199b_64bit.exe'
$checksum64     = '80F67223E0F78ACBC3B4C1874D1BF5DC07AC10FCB1CA5973547F498F6DC53D32'
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

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyZipPackage @packageArgs
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."

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
  


