# Download URLs for VMware vSphere Client (2089791)
# https://kb.vmware.com/s/article/2089791
$packageName    = 'vmwarevsphereclient' 
$installerType  = 'exe' 
$url            = 'http://vsphereclient.vmware.com/vsphereclient/3/0/1/6/4/4/7/VMware-viclient-all-6.0.0-3016447.exe'
$checksum       = '83C7B8A5B7647FBEE4AC222AB3EB5910C87062657C0D6A6582FBC8156FF25FA5'
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