$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/25016/eng/PROWin32.exe'
$checksum       = 'F82BEBF8146E20D1DF6B57F29C92B96B0EE16711A05ABEFCDB558EC99B0C4E97'
$url64          = 'https://downloadmirror.intel.com/25016/eng/PROWinx64.exe'
$checksum64     = '3B68428307CC4CC7941C62C09EF636F66DC561B8983C07C854D0F630E65CC21B'
$silentArgs     = ''
$validExitCodes = @(0)
$unzipLocation  = "$toolsDir\unzippedfiles"
$bits           = Get-ProcessorBits
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\INDInstall.ahk"

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
	$url = "$unzipLocation\APPS\SETUP\SETUPBD\Winx64\SetupBD.EXE"
   } else {
	$url = "$unzipLocation\APPS\SETUP\SETUPBD\Win32\SetupBD.EXE"
   }

Start-Process $ahkExe $ahkFile

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


