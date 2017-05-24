$packageName  = 'urban-terror' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://cdn.urbanterror.info/urt/43/releases/zips/UrbanTerror432_full.zip'
$checksum     = '74DEE1566FA6CD0EB26D866149A1B6AD7E8F18A653693F02790C05EF7CE352A4'
$shortcutName = 'Urban Terror.lnk'
$exe          = 'UrbanTerror43\Quake3-UrT.exe'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Write-Host "This download can take a while even on a fast connection!" -foreground "magenta" –backgroundcolor "blue"
Install-ChocolateyZipPackage @packageArgs

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\UrbanTerror43"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\UrbanTerror43"

