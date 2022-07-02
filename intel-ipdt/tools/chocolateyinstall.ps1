$ErrorActionPreference = 'Stop'
$packageName    = 'intel-ipdt'
$url            = "https://downloadmirror.intel.com/19792/IPDT_Installer_"+$env:ChocolateyPackageVersion+"_32bit.msi"
$checksum       = 'E4FE1FC9E9E9ED747A0B5E7932F7842B39F37260F8569B328C28FB1D66F4F8CF'
$url64          = "https://downloadmirror.intel.com/19792/IPDT_Installer_"+$env:ChocolateyPackageVersion+"_64bit.msi"
$checksum64     = 'F8C6A8D61F1F355CFB53A32817F94950A0AD2422A124D3F05F7ED2B6D2296F48'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  url64          = $url64   
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'Intel Processor Diagnostic Tool*'
  checksum       = $checksum
  checksumType   = 'sha256'
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
