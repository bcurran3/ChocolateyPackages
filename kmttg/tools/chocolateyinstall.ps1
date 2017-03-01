$packageName= 'kmttg' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://svwh.dl.sourceforge.net/project/kmttg/kmttg_v2.2q.zip'
$checksum   = '8EA9E0772B3E658F552C9CD50D9688D27DFEDB9E38BE86A7513DD42313194AE1'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\kmttg.lnk" -targetPath "$env:ChocolateyInstall\lib\kmttg\tools\kmttg.jar"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T
