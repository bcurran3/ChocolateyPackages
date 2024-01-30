# https://packages.vmware.com/tools/releases

$ErrorActionPreference = 'Stop'
$packageName       = 'vmware-tools'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/11.2.1/windows/x86/VMware-tools-11.2.1-17243207-i386.exe'
$checksum          = '1C44248C8A501B5DCC7638206883EF3CC82F659218EB018BC93C1545144B24D4'
$url64             = 'https://packages.vmware.com/tools/releases/11.2.1/windows/x64/VMware-tools-11.2.1-17243207-x86_64.exe'
$checksum64        = 'FB274CC0A5C700EF530A84DE550033E4BFE1156AD73C5B7495106FAC9E07035B'
$pp                = Get-PackageParameters

if ( $pp.ALL ) {
		Write-Host "`nPerforming a Complete installation of VMware Tools..." -ForegroundColor Yellow
		Write-Host ""
		
		$packageArgs = @{
		  packageName    = $packageName
		  fileType       = 'EXE'
		  url            = $url
		  url64bit       = $url64
		  validExitCodes = @(0, 3010)
		  silentArgs     = '/S /v /qn REBOOT=R ADDLOCAL=ALL'
		  softwareName   = 'VMware Tools'
		  checksum       = $checksum 
		  checksumType   = 'sha256' 
		  checksum64     = $checksum64
		  checksumType64 = 'sha256'
		}

		Install-ChocolateyPackage @packageArgs
} else {
		Write-Host "`nPerforming a Typical installation of VMware Tools..." -ForegroundColor Yellow
		Write-Host ""
		
		$packageArgs = @{
		  packageName    = $packageName
		  fileType       = 'EXE'
		  url            = $url
		  url64bit       = $url64
		  validExitCodes = @(0, 3010)
		  silentArgs     = '/S /v /qn REBOOT=R'
		  softwareName   = 'VMware Tools'
		  checksum       = $checksum 
		  checksumType   = 'sha256' 
		  checksum64     = $checksum64
		  checksumType64 = 'sha256'
		}

		Install-ChocolateyPackage @packageArgs
}
