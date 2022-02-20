$ErrorActionPreference = 'Stop'
$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits

# Wired Drivers
$url            = 'https://downloadmirror.intel.com/721689/Wired_driver_27.0_32.zip'
$checksum       = 'FA3F7AFD60151B5B18152395DD5A96A9B1CBCD83C55E903103CE3BC4C75D7248'
$url64          = 'https://downloadmirror.intel.com/721689/Wired_driver_27.0_x64.zip'
$checksum64     = '1840255E3CCABF68EAF3E9D4F3E015950C60C3E0DC94248ED0379601D6B69732'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64    
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  Destination    = $unzipLocation
  FileFullPath   = "$unzipLocation\Wired_driver_27.0_32.exe"
  FileFullPath64 = "$unzipLocation\Wired_driver_27.0_x64.exe"
}

Get-ChocolateyUnzip @packageArgs


pnputil /add-driver $unzipLocation\*.inf /install /subdirs

# Wired PROSet drivers
$url            = 'https://downloadmirror.intel.com/721689/Wired_PROSet_27.0_32.zip'
$checksum       = '568BFD88D3A0F98FE656664A8B71A805627E0CA5A41F7EF11A5002E2AD67DE83'
$url64          = 'https://downloadmirror.intel.com/721689/Wired_PROSet_27.0_x64.zip'
$checksum64     = '2561C7CC258EB231B73443FB6FE3250621FF3558B306697972C41D1826F54CFC'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64    
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  Destination    = $unzipLocation
  FileFullPath   = "$unzipLocation\Wired_PROSet_27.0_32.exe"
  FileFullPath64 = "$unzipLocation\Wired_PROSet_27.0_x64.exe"
}

Get-ChocolateyUnzip @packageArgs


$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$unzipLocation\APPS\PROSETDX\Win32\DxSetup.exe"
  file64         = "$unzipLocation\APPS\PROSETDX\Winx64\DxSetup.exe"
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0)
  softwareName   = 'Intel(R) Network Connections*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Start-CheckandStop msiexec
Remove-Item $unzipLocation -Recurse -EA SilentlyContinue | Out-Null

