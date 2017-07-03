$packageName   = 'neverball' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://icculus.org/neverball/neverball-1.6.0.zip'
$checksum      = '865391CC041208E526401A8EB1F14FBA44323F17D7E818C5E65E82393FF747FB'
$shortcutName  = 'Neverball.lnk'
$shortcutName2 = 'Neverputt.lnk'
$workingDir    = 'neverball-1.6.0'
$exe           = 'neverball.exe'
$exe2          = 'neverputt.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName2" -targetPath "$toolsDir\$workingDir\$exe2" -WorkingDirectory "$toolsDir\$workingDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName2" -targetPath "$toolsDir\$workingDir\$exe2" -WorkingDirectory "$toolsDir\$workingDir"