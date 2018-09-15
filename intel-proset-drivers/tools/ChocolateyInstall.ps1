$packageName    = 'intel-proset-drivers' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzippedfiles"
$bits           = Get-ProcessorBits
$url            = 'https://downloadmirror.intel.com/28147/a08/WiFi_20.80.0_PROSet32.zip'
$checksum       = 'F7A5D0CF7D2B1366C6E91562AC78542BCF44855C2E341C9AFD85D4A4CDB5BD49'
$url64          = 'https://downloadmirror.intel.com/28147/a08/WiFi_20.80.0_PROSet64.zip'
$checksum64     = 'FD7291E5D86ED47F50735575B60B7B4856625DEE56B7FDC610E65BA662EB35B0'

# No need to check for hardware, drivers install even if an Intel PROSet/Wireless card is not found

New-Item $unzipLocation -type directory | out-null

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
  fileType       = 'EXE'
  file           = "$unzipLocation\Setup.exe"
  silentArgs     = '-q -passive -norestart'
  validExitCodes = @(0)
  softwareName   = 'Intel® PROSet/Wireless Software'
}
 
Install-ChocolateyInstallPackage @packageArgs

Start-Sleep -s 10

Remove-Item $unzipLocation -recurse | out-null


