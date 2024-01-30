$ErrorActionPreference = 'Stop'
$packageName   = 'intel-me-drivers' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$pp            = Get-PackageParameters
$unzipLocation = "$toolsDir\unzippedfiles"
$url           = 'https://downloadmirror.intel.com/733739/ME_SW_2216.16.0.2805.zip'
$checksum      = '3C9EB58F9C5C0175F0D387758FB5D8135BCC684AC40C821FB4AD2742EA79006E'

New-Item $unzipLocation -Type Directory | Out-Null

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$unzipLocation\ME_SW_DCH\SetupME.exe"
  silentArgs     = '-s -preinst'                          # -overwrite removed because there are newer drivers out there (23xx.x.xx.x)
  validExitCodes = @(0)
  softwareName   = 'Intel® Management Engine Components'
}

Install-ChocolateyInstallPackage @packageArgs
	
Remove-Item $unzipLocation -Recurse -EA SilentlyContinue | Out-Null
