$packageName    = 'hp-universal-print-driver-ps' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://ftp.hp.com/pub/softlib/software13/COL40842/ds-99375-19/upd-ps-x32-6.6.5.23510.exe'
$checksum       = '9AE75B5A798DD89FCD2B6963ABA40758553D9EF9FD9E00EEB5EF1814C928E8A7'
$url64          = 'https://ftp.hp.com/pub/softlib/software13/COL40842/ds-99376-19/upd-ps-x64-6.6.5.23510.exe'
$checksum64     = '00C8CA13CBFE99746D62DB7D6413C14DAD566D834DB67AE44A442F152F505456'
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
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = '/dm /nd /npf /q /h'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = ''
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$toolsDir\unzippedfiles" -recurse | out-null
