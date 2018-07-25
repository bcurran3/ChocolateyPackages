$packageName= 'lanbench' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://web.archive.org/web/20160320195359/http://www.zachsaw.com/downloads/lanbench_v1.1.0.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = '0A9FAC1C0987F4B70F6EE9663FCF21551BCCDC9CFF5BD94AF8557249D2983644'
  checksumType  = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\LANBench.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\LANBench.exe"
