$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/25016/eng/PROWin32.exe'
$checksum       = '73366E31F83EB789269E519BF14B31C408BAA71BAB7EBE9C60EAF1FE352C8093'
$url64          = 'https://downloadmirror.intel.com/25016/eng/PROWinx64.exe'
$checksum64     = '724C5D98C68919A1B7BD971032EEE11F8CADF9B28856D56B72FB0B9F3B3206BB'
$validExitCodes = @(0)
$bits           = Get-ProcessorBits

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64    
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

if ($bits -eq 64)
   {
	$url = Join-Path $toolsDir 'APPS\SETUP\SETUPBD\Winx64\SetupBD.EXE'
   } else {
	$url = Join-Path $toolsDir 'APPS\SETUP\SETUPBD\Win32\SetupBD.EXE'
   }
   
#Set-Location -Path $toolsDir
	
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'Intel(R) Network Connections*'
}
 
