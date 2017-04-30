$packageName = 'resedit' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://rsdt.free.fr/ResEdit-win32.7z'
$checksum    = '0512802BDA328DDFF71B7B7E7C1C9C029AE9D6F5325D94D8E627ED34A8CD0A88'
$url64       = 'http://rsdt.free.fr/ResEdit-x64.7z'
$checksum64  = '7AC156280B43917AA2D4B9B6768B6E97C275C87E2B82624A81B64CB99110949F'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\ResEdit.lnk" -targetPath "$toolsDir\ResEdit.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\ResEdit.lnk" -targetPath "$toolsDir\ResEdit.exe" 

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null