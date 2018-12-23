$packageName    = 'dokany'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dokan-dev/dokany/releases/download/v1.2.1.2000/Dokan_x86.msi' 
$checksum       = '19371DBFD65EF554C23E5C43A390686BB152F0A41F66D23FAB56213CB36EF333'
$url64          = 'https://github.com/dokan-dev/dokany/releases/download/v1.2.1.2000/Dokan_x64.msi' 
$checksum64     = '735FB096DB5CC1DD02A0D91951E2638CCA4F5F2F3A0AEEF9ABF270E2BD051196'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/passive /norestart'
  softwareName  = 'Dokan Library*'
  checksum      = $checksum
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  
