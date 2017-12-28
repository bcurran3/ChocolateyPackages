$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'hp-universal-print-driver-ps' 
$url            = 'http://ftp.hp.com/pub/softlib/software13/COL40842/ds-99375-14/upd-ps-x32-6.5.0.22695.exe'
$checksum       = '782DA57EAC8465F3B120FBFCBE0705F34C43054C9F596675866EE2EF09DE92EB'
$url64          = 'http://ftp.hp.com/pub/softlib/software13/COL40842/ds-99376-14/upd-ps-x64-6.5.0.22695.exe'
$checksum64     = 'B0F5F82F9E1074ECC041DEDC75607223C68C740772BE800313A6837F75B66326'
$installerType  = 'ZIP'
$silentArgs     = '/dm /nd /npf /q /h'
$validExitCodes = @(0, 3010, 1641)
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
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$toolsDir\unzippedfiles" -recurse | out-null

