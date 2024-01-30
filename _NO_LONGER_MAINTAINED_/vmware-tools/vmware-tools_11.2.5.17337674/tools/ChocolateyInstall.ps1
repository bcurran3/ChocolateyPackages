# https://packages.vmware.com/tools/releases

$ErrorActionPreference = 'Stop'
$packageName           = 'vmware-tools'
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = 'https://packages.vmware.com/tools/releases/11.2.5/windows/x86/VMware-tools-11.2.5-17337674-i386.exe'
$checksum              = '4574457C1D8B45C29C4890B736644D49CC0FC544BCEC653ADEFFF6AADCA67F7B'
$url64                 = 'https://packages.vmware.com/tools/releases/11.2.5/windows/x64/VMware-tools-11.2.5-17337674-x86_64.exe'
$checksum64            = '647AF568B8A45FD79DB3717186B4F7037ACA2990F74E641C3F50B107829F96E3'
$pp                    = Get-PackageParameters

if ( $pp.ALL ) {
        Write-Host "`nPerforming a Complete installation of VMware Tools...`n" -ForegroundColor Yellow
        
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
        Write-Host "`nPerforming a Typical installation of VMware Tools...`n" -ForegroundColor Yellow
        
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
