$ErrorActionPreference = 'Stop'
$packageName    = 'intel-ipdt'
$url            = 'https://downloadmirror.intel.com/19792/eng/ipdt_installer_4.1.2.34_32bit.exe'
$checksum       = 'C5ACEE3B50C106B484A413D37D72D061779B20A17CA270C46CFCD95EC9324F56'
$url64          = 'https://downloadmirror.intel.com/19792/eng/ipdt_installer_4.1.2.34_64bit.exe'
$checksum64     = 'CED922C161DC430BE68FEA819C7E2446A8E916DA4EE9F69294BCC8E7C13EE18B'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  url64          = $url64   
  silentArgs     = '/install /quiet /norestart'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'Intel Processor Diagnostic Tool*'
  checksum       = $checksum
  checksumType   = 'sha256'
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
