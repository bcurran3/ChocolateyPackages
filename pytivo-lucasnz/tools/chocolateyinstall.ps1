$packageName= 'pytivo-lucasnz' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/lucasnz/pytivo/archive/master.zip'
$checksum   = 'CD1636FB5317CE166864F46A3E2462D832FD5C16FD8247462D0677AEFB4C8D1F'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\PyTiVo.lnk" -targetPath "$env:ChocolateyInstall\lib\pytivo-lucasnz\tools\pytivo-master\pytivo.py" -iconLocation "$env:ChocolateyInstall\lib\$packageName\tools\pytivo.ico" -workingDirectory "$env:ChocolateyInstall\lib\$packageName\tools\pytivo-master\"
