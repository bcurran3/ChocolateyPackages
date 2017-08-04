$packageName    = 'neat-update'
$installerType  = 'exe'
$url            = 'http://cdn.neatco.com/Neat_v5.7.1.474_UPDATE.sfx.exe'
$checksum       = 'D3BFCA841670D85B3C1FD5CF39994C9175D1C774A01EF593646B22F847FEB5A6'
$silentArgs     = '/S'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0, 3010, 1641)
$softwareName   = 'Neat*'
$unzipLocation  = "$toolsDir\unzipped"
$realInstaller  = "Neat v5.7.1 FULL.exe"

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

