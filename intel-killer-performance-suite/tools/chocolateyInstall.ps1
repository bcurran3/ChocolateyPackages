$ErrorActionPreference = 'Stop'
$packageName    = 'intel-killer-performance-suite' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = "https://downloadmirror.intel.com/30388/a08/KillerPerformanceSuite_"+$env:ChocolateyPackageVersion+"_UWD_x64.exe"
$checksum64     = '33054CF31E78EDC576ACD2152FA1D221021F33BE43E61A4417197EDCFC8F6CF5'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url64          = $url64
  silentArgs     = '/S /v/qn /V/norestart'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'Killer Performance Driver Suite UWD'
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
