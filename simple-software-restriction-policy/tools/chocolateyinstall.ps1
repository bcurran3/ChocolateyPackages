$ErrorActionPreference = 'Stop'
$packageName= 'simple-software-restriction-policy'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "$toolsDir\SoftwarePolicy210Setup.exe"
 
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  checksum      = 'B22502F28AE5BC4B545FF303F6125800F5C8EBC37FECD176053EAEAAAA553138'
  checksumType  = 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'Software Policy*'
}
 
Install-ChocolateyPackage @packageArgs
Remove-Item $toolsDir\SoftwarePolicy210Setup.exe
