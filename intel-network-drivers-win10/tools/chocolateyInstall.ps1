$ErrorActionPreference = 'Stop'
$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits
$url            = 'https://downloadmirror.intel.com/25016/eng/PROWin32.zip'
$checksum       = '3D2A739DB58CEC4E44E157159C7798CC67834E2C738851531D7103C56F802CA6'
$url64          = 'https://downloadmirror.intel.com/25016/eng/PROWinx64.zip'
$checksum64     = '7042E15535EB3FD557D4B395CD091A1AAB8587CB59EA56310C0CA89DE23255CB'
# URLs are static between versions

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64    
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  Destination    = $unzipLocation
  FileFullPath   = "$unzipLocation\PROWin32.exe"
  FileFullPath64 = "$unzipLocation\PROWinx64.exe"
}

Get-ChocolateyUnzip @packageArgs


$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$unzipLocation\APPS\PROSETDX\Win32\DxSetup.exe"
  file64         = "$unzipLocation\APPS\PROSETDX\Winx64\DxSetup.exe"
  silentArgs     = '/qn'
  validExitCodes = @(0)
  softwareName   = 'Intel(R) Network Connections*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Start-Sleep -s 10

Remove-Item $unzipLocation -Recurse -EA SilentlyContinue | Out-Null
