$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'hp-universal-print-driver-pcl' 
$url            = 'https://ftp.hp.com/pub/softlib/software13/COL40842/ds-99353-19/upd-pcl6-x32-6.6.5.23510.exe'
$checksum       = '22590F3FAA980AE1C880DFF3DDFDB5BEB5179CD2F8A8C4A216B2CFA0B412F0D1'
$url64          = 'https://ftp.hp.com/pub/softlib/software13/COL40842/ds-99374-19/upd-pcl6-x64-6.6.5.23510.exe'
$checksum64     = 'E114E230D955EC4A38375F33C98F8A91A1346FCEBDD469B93F47A0A37BB040AD'
$softwareName   = ''
$fileLocation   = "$toolsDir\unzippedfiles\install.exe"

# Make sure Print Spooler service is up and running stolen from cutepdf package.
try {
  $serviceName = 'Spooler'
  $spoolerService = Get-WmiObject -Class Win32_Service -Property StartMode,State -Filter "Name='$serviceName'"
  if ($spoolerService -eq $null) { throw "Service $serviceName was not found" }
  Write-Host "Print Spooler service state: $($spoolerService.StartMode) / $($spoolerService.State)"
  if ($spoolerService.StartMode -ne 'Auto' -or $spoolerService.State -ne 'Running') {
    Set-Service $serviceName -StartupType Automatic -Status Running
    Write-Host 'Print Spooler service new state: Auto / Running'
  }
} catch {
  Write-Warning "Unexpected error while checking Print Spooler service: $($_.Exception.Message)"
}

New-Item $fileLocation -type directory | out-null

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = "$toolsDir\unzippedfiles"
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
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = '/dm /nd /npf /q /h'
  validExitCodes= @(0, 3010, 1641)
  softwareName  = $softwareName
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$toolsDir\unzippedfiles" -recurse | out-null
