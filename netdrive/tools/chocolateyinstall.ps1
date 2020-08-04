$ErrorActionPreference = 'Stop'
$packageName    = 'netdrive'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://files.bdrive.com/netdrive/builds/e52f058a8a124f19812c7ff6ccef62e9/NetDrive3_Setup-3.8.987.exe'
$checksum       = '7CF964FE98957F7805E8D37F2D0A96F659C8401EC7D33E909BB54A4895BFC88E'
$extractDir     = "$toolsDir\extracted"
$fileLocation   = "$extractDir\NetDrive3.msi"

# switch to MSI dl -- msiexec /i NetDrive3-version.msi REINSTALL=ALL REINSTALLMODE=vamus

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
  packageName    = $packageName
  fileType       = 'MSI'
  file           = $fileLocation
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0,1223)
  softwareName   = 'NetDrive*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $extractDir -Recurse | Out-Null
