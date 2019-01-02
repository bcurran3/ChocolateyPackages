$packageName    = 'netdrive'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://files.bdrive.com/netdrive/builds/d459a3ca4c0341d7ba2102b42ae61921/NetDrive3_Setup-3.6.571.exe' 
$checksum       = '6FA986BABEE83D8CCF767CE7A146AFDF1BC1FF7E3CD1B2D3A5AD705DC4F610CF'
$extractDir     = "$toolsDir\extracted"
$fileLocation   = "$extractDir\NetDrive3.msi"

New-Item $extractDir -type directory

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extractDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $fileLocation
  silentArgs    = '/quiet /qn /norestart'
  validExitCodes= @(0,1223)
  softwareName  = 'NetDrive*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $extractDir -recurse | out-null
