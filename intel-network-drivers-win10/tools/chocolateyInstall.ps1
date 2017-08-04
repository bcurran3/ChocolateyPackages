$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloadmirror.intel.com/25016/eng/PROWin32.exe'
$checksum       = 'A5654527E3C8FEC3BD112E7005AB7BF51491607D068ABC3C35078EA7C37875C3'
$url64          = 'https://downloadmirror.intel.com/25016/eng/PROWinx64.exe'
$checksum64     = 'CAD05400F61D42D5B5A2ADF57F1BB1DACE9042494524ECD45B723CA893CBFAA2'
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


