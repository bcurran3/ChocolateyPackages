# Ubuntu-1604 doesn't support being silently installed. This script kludges it.
$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-ubuntu-1604'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://aka.ms/wsl-ubuntu-1604'
$checksum       = '24F2926D359B6ABAE595CDA7300AEDC567C294777D4BFC8AACC0E6598DB9680A'
$unzipLocation  = "$toolsDir\unzipped"

New-Item $unzipLocation -type directory | out-null

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# open Ubuntu-1604 installer in a new window
Set-Location -Path $unzipLocation
Start-Process ./ubuntu.exe

Write-Host "  ** When you see ""Installation successful!"" in the other window, you may close it." -foreground magenta
Write-Host "  ** Otherwise, just wait up to 25 seconds and it will close automatically." -foreground magenta

# Make sure Ubuntu-1604 starts setting up and doesn't give an error
Start-Sleep -Seconds 5
if (Test-Path $unzipLocation\rootfs)
   {
# wait for Ubuntu-1604 installer to finish extracting files
    $LoopMePlease=1
    while (!(Test-Path $unzipLocation\rootfs\var\tmp)){
           Start-Sleep -Seconds 15
		   $LoopMePlease++
		   if ($LoopMePlease -gt 60) {break} # break out of the loop after 15 minutes
          }
    } else {
	  Write-Warning "Something went wrong. Possibly you haven't rebooted since enabling WSL."
	  $SomethingWentWrong=$true
	 }

# wait 10 more seconds to make sure the files IN rootfs\var\tmp get extracted
if (!($SomethingWentWrong)) {Start-Sleep -Seconds 10}

# terminate ubuntu.exe ~when it hits the "Enter new UNIX username:" prompt (meaning installation has finished)
Start-CheckandStop "ubuntu"

if ($SomethingWentWrong) {throw}

Install-BinFile -Name Ubuntu1604 -Path "$unzipLocation\ubuntu.exe"
Write-Host "  ** root is the default user upon running WSL/Ubuntu." -foreground magenta
wslconfig /list
