$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/25016/eng/PROWin32.exe'
$checksum       = 'E6EDC800FCCAA8CB44DCE93CBBD98764576E9E1DEC67BA73B9A7C1A105EAF04F'
$url64          = 'https://downloadmirror.intel.com/25016/eng/PROWinx64.exe'
$checksum64     = '7525C261A780346686B8655062886430D6795DCE47DC0AC13F4C81D5D05F5189'
$silentArgs     = '/qn'
$validExitCodes = @(0)
$unzipLocation  = "$toolsDir\unzippedfiles"
$bits           = Get-ProcessorBits

$card = wmic path win32_NetworkAdapter get name
if ($card -match "Intel")
  {
   write-host "You've got $card!" -foreground "green" 
  } else {
   write-host "No Intel network adapters found. Aborting." -foreground "red"
   throw
   }

New-Item $unzipLocation -type directory | out-null

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

if ($bits -eq 64)
   {
	$url = "$unzipLocation\APPS\PROSETDX\Winx64\DxSetup.exe"
   } else {
	$url = "$unzipLocation\APPS\PROSETDX\Win32\DxSetup.exe"
   }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'Intel(R) Network Connections*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Start-Sleep -s 10

Remove-Item $unzipLocation -recurse | out-null


