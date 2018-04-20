# Download URLs for VMware vSphere Client (2089791)
# https://kb.vmware.com/s/article/2089791
$packageName    = 'vmwarevsphereclient' 
$installerType  = 'exe' 
$url            = 'http://vsphereclient.vmware.com/vsphereclient/5/1/1/2/5/0/8/VMware-viclient-all-6.0.0-5112508.exe'
$checksum       = '36224467F8B0DC26738828B65F351E5728CFF88DAB2C0224119DF81F8C47B9E4'
$silentArgs     = '/s /w /v" /qb"' 
$validExitCodes = @(0) 

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'VMware vSphere Client 6*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  