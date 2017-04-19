$ErrorActionPreference = 'Stop'
$packageName= 'sardu' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.sarducd.it/download/SARDU_320.zip'
$checksum   = '0B523F111BCFCAE011B8DA2148BF731401B41EC1BCBFB1720A4245B11FF4F051'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\SARDU.lnk" -targetPath "$toolsDir\SARDU_320\sardu_3.exe" -WorkingDirectory "$toolsDir\SARDU_320"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\SARDU.lnk" -targetPath "$toolsDir\SARDU_320\sardu_3.exe" -WorkingDirectory "$toolsDir\SARDU_320"