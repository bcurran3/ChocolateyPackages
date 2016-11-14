$ErrorActionPreference = 'Stop'
$packageName= 'address-tagging-exchange' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download-address-tagging-for-exchange.exclaimer.com/Setup.exe'
$checksum   = '9806408CFC071C9428C3CC108ECADAC012146FD553CFD0C69C454B891920F358'
$silentArgs = '/quiet /norestart'
$validExitCodes= @(0, 3010, 1641)
$fileLocation = "$env:ChocolateyInstall\lib\$packageName\tools\Address Tagging Install.msi"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Address Tagging for Exchange*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$env:ChocolateyInstall\lib\$packageName\tools\Address Tagging Install.msi"
Remove-Item "$env:ChocolateyInstall\lib\$packageName\tools\Bootstrapper_Install.bat"
