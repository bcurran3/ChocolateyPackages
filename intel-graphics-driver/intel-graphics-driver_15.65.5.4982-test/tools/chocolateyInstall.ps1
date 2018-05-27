 $packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = ''
$checksum    = ''
$url64       = 'https://downloadmirror.intel.com/27650/a08/win64_15.65.5.4982.exe'
$checksum64  = 'AD1A6E692651466326C5FB7234E03FBD2D25626ED82AC79CAD5DF7857467F34D'
#$silentArgs  = '-s -overwrite'
$silentArgs  = '-s'
$validExitCodes = @(0)
$unzipLocation  = "$toolsDir\unzippedfiles"
$bits        = Get-ProcessorBits

if ($bits -eq 32)
  {
   Write-Host "This version is only for 64 bit OSes." -foreground "red" –backgroundcolor "blue"
   throw
  }

$card = wmic path win32_VideoController get name
if ($card -match "Intel")
  {
   write-host "You've got $card!" -foreground "green" –backgroundcolor "blue"
  } else {
   write-host "No Intel display adapters found. Aborting." -foreground "red" –backgroundcolor "blue"
   throw
   }

New-Item $unzipLocation -type directory | out-null

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'EXE' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64    
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

$url = "$unzipLocation\igxpin.exe"
write-host URL is $url

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'Intel® Graphics Driver' 
}
 
Install-ChocolateyInstallPackage @packageArgs

#Start-Sleep -s 10

#Remove-Item $unzipLocation -recurse | out-null

