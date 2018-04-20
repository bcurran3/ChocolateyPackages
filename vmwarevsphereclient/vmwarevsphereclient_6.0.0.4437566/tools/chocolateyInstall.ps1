# Download URLs for VMware vSphere Client (2089791)
# https://kb.vmware.com/s/article/2089791
$packageName    = 'vmwarevsphereclient' 
$installerType  = 'exe' 
$url            = 'http://vsphereclient.vmware.com/vsphereclient/4/4/3/7/5/6/6/VMware-viclient-all-6.0.0-4437566.exe'
$checksum       = '2DBD83683479D573098A654F2BF7472D7C2B9953CE8789DAA45D389999C4E1BC'
$silentArgs     = '/s /w /v" /qb"' 
$validExitCodes = @(0) 

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'VMware Tools'
  checksum      = $checksum 
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  