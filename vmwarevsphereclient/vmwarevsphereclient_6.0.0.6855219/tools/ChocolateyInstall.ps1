$ErrorActionPreference = 'Stop'
# Download URLs for VMware vSphere Client (2089791)
# https://kb.vmware.com/s/article/2089791
$packageName    = 'vmwarevsphereclient' 
$url            = 'http://vsphereclient.vmware.com/vsphereclient/6/8/5/5/2/1/9/VMware-viclient-all-6.0.0-6855219.exe'
$checksum       = '7C70CD24B71B588F22425C92DA90CECE90D95FF222DC6297EEF10D6F27306ADC'
$silentArgs     = '/s /w /v" /qb"' 
$validExitCodes = @(0) 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'VMware vSphere Client 6*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
