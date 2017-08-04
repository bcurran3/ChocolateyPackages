$packageName    = 'neat'
$installerType  = 'exe'
$url            = 'http://cdn.neatco.com/Neat_v5.4.1.273_FULL.sfx.exe'
$checksum       = '6D204CDA1EEC58E4CFD3ACFE1739BF42855C08FC944F8E6EBE14F46239A1AD92'
$silentArgs     = '/S'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0, 3010, 1641)
$softwareName   = 'Neat*'
$unzipLocation  = "$toolsDir\unzipped"
$realInstaller  = "Neat v5.4.1 FULL.exe"

New-Item $unzipLocation -type directory | out-null

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
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $unzipLocation -recurse | out-null

