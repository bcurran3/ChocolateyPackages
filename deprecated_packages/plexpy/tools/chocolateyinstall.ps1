$packageName= 'plexpy' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/JonnyWong16/plexpy/archive/v1.4.21.zip'
$checksum   = '41AA076E77293659EAE27CB9D56AA44866782F7B5791BBD6325B9017BA08D212'
$extractDir = 'plexpy-1.4.21'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\PlexPy.lnk" -targetPath "$toolsDir\$extractDir\plexpy.py" -WorkingDirectory "$toolsDir\$extractDir" -IconLocation "$toolsDir\$extractDir\data\interfaces\default\images\favicon.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PlexPy.lnk" -targetPath "$toolsDir\$extractDir\plexpy.py" -WorkingDirectory "$toolsDir\$extractDir" -IconLocation "$toolsDir\$extractDir\data\interfaces\default\images\favicon.ico"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
