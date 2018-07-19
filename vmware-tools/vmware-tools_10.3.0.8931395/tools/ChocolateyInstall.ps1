$ErrorActionPreference = 'Stop'
$global:packageMaintainer = 'BCURRAN3'
$packageName       = 'vmware-tools'
$installerType     = 'exe'
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url               = 'https://packages.vmware.com/tools/releases/10.3.0/windows/x86/VMware-tools-10.3.0-8931395-i386.exe'
$checksum          = '31E083D591D2E533BB6949477DDEF8A19E4177A5043A21DE91D58F7674D94C85'
$url64             = 'https://packages.vmware.com/tools/releases/10.3.0/windows/x64/VMware-tools-10.3.0-8931395-x86_64.exe'
$checksum64        = '3CE8C31677308E83B1C9C836035EC4801BDB7AE5613887D42B5A35DD1F89ABA2'
$silentArgs        = '/S /v /qn REBOOT=R'
$validExitCodes    = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'VMware Tools'
  checksum      = $checksum 
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs  
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."
