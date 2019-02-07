$ErrorActionPreference = 'Stop'
$packageName    = 'neat'
$url            = 'https://s3.amazonaws.com/legacy-installers/latest/Neat_v5.7.1.474_FULL.sfx.exe'
$checksum       = '19E5C4A1351B948FA6E140AFEF8BD6C0A605BF41032DA5AFDF196E6E349796'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$realInstaller  = 'Neat v5.7.1 FULL.exe'
 
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP'
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}
 
Install-ChocolateyZipPackage @packageArgs 
 
$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $unzipLocation + "\" + '$OUTDIR' + "\" + $realInstaller
  silentArgs    = '/S'
  validExitCodes= @(0, 3010, 1641)
  softwareName  = 'Neat*'
}
  
Install-ChocolateyInstallPackage @packageArgs
 
Remove-Item $unzipLocation -Recurse | Out-Null
