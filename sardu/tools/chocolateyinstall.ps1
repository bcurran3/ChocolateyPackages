$ErrorActionPreference = 'Stop'
$packageName   = 'sardu' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.sarducd.it/download/SARDU_330.zip'
$checksum      = '4CA7CE06A2568BF4C81B43B9F8D6DEC52F2075E74AF912AF9D604EC3AD277B95'
$TodaysVersion = ($ENV:ChocolateyPackageVersion -replace '[.]','')
$shortcutName  = 'SARDU.lnk'
$workingDir    = "SARDU_$TodaysVersion"
$exe           = 'sardu_3.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"
