$packageName= 'acddokannet'
$installerType = 'msi'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/Rambalac/ACDDokanNet/releases/download/v1.6.2/ACDDokanNetInstaller.msi' 
$checksum   = '87334CD92906A4DA4C9BD9ACD3B9FAE76F0921419F407FF01579337FCB059900'
$silentArgs = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'ACDDokanNet*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
