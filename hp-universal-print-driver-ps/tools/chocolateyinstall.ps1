﻿$ErrorActionPreference = 'Stop'
$packageName    = 'hp-universal-print-driver-ps' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://ftp.hp.com/pub/softlib/software13/COL40842/ds-99375-22/upd-ps-x32-6.8.0.24296.exe'
$checksum       = '7F224595CF4EFBFE6C50B7541FCFB8841A62B304151219433E735897DB3B63D7'
$url64          = 'https://ftp.hp.com/pub/softlib/software13/COL40842/ds-99376-22/upd-ps-x64-6.8.0.24296.exe'
$checksum64     = '151FD3746DDD47A1B4DB9C98032F84AAB71AB2D2A957147D32C829421A22E9F6'
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

New-Item $fileLocation -Type directory | Out-Null

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

Remove-Item "$toolsDir\unzippedfiles" -Recurse | Out-Null
