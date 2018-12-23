$packageName    = 'intel-proset-drivers' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzippedfiles"
$bits           = Get-ProcessorBits
$url            = 'https://downloadmirror.intel.com/28358/a08/WiFi_20.100_PROSet32_Win10.exe'
$checksum       = 'E58627DD0079E087CF0BD61F7707520A4D36B28F1A8509D075B4E8643BBA37A0'
$url64          = 'https://downloadmirror.intel.com/28358/a08/WiFi_20.100_PROSet64_Win10.exe'
$checksum64     = '4F698B3AF33299831B94BDB4C98D099BBDE8B5236CD0B87BD47F675E72FF19C9'

# Verify Windows 10 and throw if not
if (!(Test-Dependency "dependency-windows10")) {throw}

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


