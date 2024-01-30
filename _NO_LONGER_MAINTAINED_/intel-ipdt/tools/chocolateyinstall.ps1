$ErrorActionPreference = 'Stop'
$packageName    = 'intel-ipdt'
$url            = "https://downloadmirror.intel.com/19792/IPDT_Installer_"+$env:ChocolateyPackageVersion+"_32bit.msi"
$checksum       = '3350402FBEFEA31E9D2C1B2F2CF599E7675C6FA44E8E3BB6ECA9E9A3FF69B813'
$url64          = "https://downloadmirror.intel.com/19792/IPDT_Installer_"+$env:ChocolateyPackageVersion+"_64bit.msi"
$checksum64     = '44E4EE0C21D18A1736713A29CDB9B1FE910671A74EF6EC6C012771E6EFF6F3AE'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  url64          = $url64   
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'Intel Processor Diagnostic Tool*'
  checksum       = $checksum
  checksumType   = 'sha256'
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
