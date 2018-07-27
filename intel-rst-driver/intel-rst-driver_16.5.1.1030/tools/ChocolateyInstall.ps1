$packageName = 'intel-rst-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloadmirror.intel.com/27984/eng/SetupRST.exe'
$checksum    = 'D6566339455DD76ACD5802353960837D7283F844AD3AE26279602BD24367E9F9'
$silentArgs  = '-s' 

if ((Get-IsWin10 -eq $false) -and (Get-IsWinServer2016 -eq $false)){
   Write-Host "This version is Windows 10 and Windows Server 2016 only." -foreground red
   throw
}

if (Get-PendingReboot -eq $true){
   Write-Host "This package will fail if there is a pending reboot." -foreground red
   Write-Host "There is a pending reboot. Please reboot and try again." -foreground red   
   throw
}

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = $silentArgs
  softwareName  = 'Intel(R) Rapid Storage Technology' 
  }
Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs
Show-ToastMessage "Intel(R) Rapid Storage Technology installed." "Version $env:packageVersion."

