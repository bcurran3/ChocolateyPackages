$ErrorActionPreference = 'Stop'
$packageName= 'sardu' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.sarducd.it/download/SARDU_311.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
    checksum    = '9B8A124B5C2C7986497B6694590E77099E481964DA170F2EF04B8C9ACA1BE169'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\SARDU.lnk" -targetPath "$toolsDir\SARDU_311\sardu_3.exe" -WorkingDirectory "$toolsDir\SARDU_311"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\SARDU.lnk" -targetPath "$toolsDir\SARDU_311\sardu_3.exe" -WorkingDirectory "$toolsDir\SARDU_311"