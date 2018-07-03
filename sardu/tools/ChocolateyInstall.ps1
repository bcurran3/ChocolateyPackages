$packageName  = 'sardu' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://www.sarducd.it/download/SARDU_324.zip'
$checksum     = '26F78DCA7B2FECBA835CF22F83551564D3A05D2EDBA6FBB96D21C8DFF14D7108'
$shortcutName = 'SARDU.lnk'
$workingDir   = 'SARDU_324'
$exe          = 'sardu_3.exe'

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