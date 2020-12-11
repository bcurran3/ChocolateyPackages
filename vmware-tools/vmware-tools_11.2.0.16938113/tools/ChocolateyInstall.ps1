# https://packages.vmware.com/tools/releases

$ErrorActionPreference = 'Stop'
$packageName       = 'vmware-tools'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/11.2.0/windows/x86/VMware-tools-11.2.0-16938113-i386.exe'
$checksum          = 'BAA86197B7B2E51D6EF60B6C1C8B4209D8496E8641D0940AAF0B907E6FCB5D37'
$url64             = 'https://packages.vmware.com/tools/releases/11.2.0/windows/x64/VMware-tools-11.2.0-16938113-x86_64.exe'
$checksum64        = '12E5190ABCD12C301A1BF04CDADAE471B590A349D5C45BDDD2CAE1B39F258DA5'
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
