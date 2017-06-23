$ErrorActionPreference = 'Stop'
$packageName   = 'vmware-tools'
$installerType = 'exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://packages.vmware.com/tools/esx/6.0u1/windows/x86/VMware-tools-9.10.5-2981885-i386.exe' 
$checksum      = 'FFC5A780C430F1C17F83A3EF61184FC37249996487DB54771B34EF7A62AD856B'
$url64         = 'https://packages.vmware.com/tools/esx/6.0u1/windows/x64/VMware-tools-9.10.5-2981885-x86_64.exe' 
$checksum64    = 'BDDACE73643FBDF6FF0AD02F5B076FCB88552488FB4C24132CA91548F40CC3AF'
$silentArgs    = '/S /v /qn'
$validExitCodes= @(0)

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

Install-ChocolateyPackage @packageArgs  
  
