$ErrorActionPreference = 'Stop'
$packageName  = 'tiny-pxe-server' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = "$toolsDir\pxesrv.zip"
$checksum     = 'D310CDDFB0BEACD5649A2F4BE49373697A3F3615FAD62CADEFB762970B565020'
$shortcutName = 'TinyPXE Server.lnk'
$exe          = 'pxesrv.exe'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
}

Install-ChocolateyZipPackage @packageArgs

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe"       

Remove-Item $url -Force | Out-Null
