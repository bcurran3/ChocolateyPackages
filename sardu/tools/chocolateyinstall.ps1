$ErrorActionPreference = 'Stop'
$packageName   = 'sardu' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.sarducd.it/download/SARDU_340.zip'
$checksum      = '286EA566AA82E6DBFDA29F1F20CC5CA1960C8DD4885999E4D82719C96F303181'
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
