$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/25016/eng/PROWin32.exe'
$checksum       = '0E706B84E64E0DF78593CB3ACD0297C17B40703C49EA5DDF01582316ACE5E7B9'
$url64          = 'https://downloadmirror.intel.com/25016/eng/PROWinx64.exe'
$checksum64     = 'C81473B326CD82032353A9133A95D04FB7F32E49912BC68C20E7249DBD8C5108'
$silentArgs     = '/qn'
$validExitCodes = @(0)
$unzipLocation  = "$toolsDir\unzippedfiles"
$bits           = Get-ProcessorBits

$card = wmic path win32_NetworkAdapter get name
if ($card -match "Intel")
  {
   write-host "You've got $card!" -foreground "green" –backgroundcolor "blue"
  } else {
   write-host "No Intel network adapters found. Aborting." -foreground "red" –backgroundcolor "blue"
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


