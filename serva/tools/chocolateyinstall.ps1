$ErrorActionPreference = 'Stop'
$packageName = 'serva' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.vercot.com/~serva/download/Serva_Community_v4.0.0.zip'
$checksum    = '1FE1443144BECB46E16E07B679C8E1070BBE87E2422F9AD9B6A0396E62698FD5'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

if (Get-ProcessorBits 64) {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Serva.lnk" -targetPath "$toolsDir\Serva64.exe" -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Serva.lnk" -targetPath "$toolsDir\Serva64.exe" -WorkingDirectory "$toolsDir"
  } else {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Serva.lnk" -targetPath "$toolsDir\Serva32.exe" -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Serva.lnk" -targetPath "$toolsDir\Serva32.exe" -WorkingDirectory "$toolsDir"
  }
  
$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null
