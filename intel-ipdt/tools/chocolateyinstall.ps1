$ErrorActionPreference = 'Stop'
$packageName    = 'intel-ipdt'
$url            = 'https://downloadmirror.intel.com/19792/eng/ipdt_installer_4.1.5.37_32bit.msi'
$checksum       = '05168596E7B5F7F5778125858454C0E4BB7A04997F67274831C7F5F24D058C6C'
$url64          = 'https://downloadmirror.intel.com/19792/eng/ipdt_installer_4.1.5.37_64bit.msi'
$checksum64     = 'FAFE723C3FF07086183693BEE910F8240AED9B1B6698008C0410DBC2F95CCAE4'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  url64          = $url64   
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'Intel Processor Diagnostic Tool*'
  checksum       = $checksum
  checksumType   = 'sha256'
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
