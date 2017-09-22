$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/25016/eng/PROWin32.exe'
$checksum       = 'F889774B7D60B555F005EA0CDB0EF47B319E449EEAC58AC02C660CF70ACFA482'
$url64          = 'https://downloadmirror.intel.com/25016/eng/PROWinx64.exe'
$checksum64     = 'ADF513CC58B5D2390EE096628F4E643A9BA496B5EF2A31F7B37F53BB167C7911'
$silentArgs     = ''
$validExitCodes = @(0)
$unzipLocation  = "$toolsDir\unzippedfiles"
$bits           = Get-ProcessorBits
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\INDInstall.ahk"

if (Get-NetAdapter -physical | where interfacedescription -match Intel)
  {
   write-host  
   write-host "You've got Intel!" -foreground "green" –backgroundcolor "blue"
  } else {
   write-host  
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


