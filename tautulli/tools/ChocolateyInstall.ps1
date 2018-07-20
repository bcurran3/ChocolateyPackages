$packageName  = 'tautulli' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/Tautulli/Tautulli/archive/v2.1.14.zip'
$checksum     = '40244ADBE1F8750273ED60AACAF0148B148C90C8C6B9E25E08018B90BFCF3D92'
$extractDir   = 'Tautulli-2.1.14'
$shortcutName = 'Tautulli.lnk'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyZipPackage @packageArgs
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$extractDir\Tautulli.py" -WorkingDirectory "$toolsDir\$extractDir" -IconLocation "$toolsDir\$extractDir\data\interfaces\default\images\favicon\favicon.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$extractDir\Tautulli.py" -WorkingDirectory "$toolsDir\$extractDir" -IconLocation "$toolsDir\$extractDir\data\interfaces\default\images\favicon\favicon.ico"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
