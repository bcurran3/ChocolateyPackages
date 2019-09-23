$ErrorActionPreference = 'Stop'
$packageName    = 'intel-ipdt'
$url            = 'https://downloadmirror.intel.com/19792/eng/ipdt_installer_4.1.4.36_32bit.exe'
$checksum       = 'BD04E81171BA3DA07E842908CECFBD3AA5C78EE76B68C6E814183EBCF715F993'
$url64          = 'https://downloadmirror.intel.com/19792/eng/ipdt_installer_4.1.4.36_64bit.exe'
$checksum64     = '61AA4DCE6F63B8B25D58B71356AA6F27F4874953670112D7ECE313172AD26EDE'

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
