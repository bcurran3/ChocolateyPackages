$packageName = 'roost-desktop-notifier-for-nest' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://nest.richardeverett.com/notifierfornest/setup.exe' 
$checksum    = '0C10F511A089DA138C58A42F1EB7B51BC119680D7F9DE893C3DBEFCAFCBA2BA4'
$ahkExe      = 'AutoHotKey'

Start-CheckandStop "NotifierForNest"  

if (Get-IsWin10){
    $ahkFile = "$toolsDir\RoostInstallWin10.ahk"
   } else {
     $ahkFile = "$toolsDir\RoostInstallpreWin10.ahk"
    }
 
Start-Process $ahkExe $ahkFile
 
 $packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  silentArgs     = ''
  validExitCodes = @(0)  
  softwareName   = 'Roost Desktop Notifier*'
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs
Start-Sleep -s 30
if ($ProcessWasRunning -eq "True") {&"$ProcessFullPath"}
# Note related to uninstall:
# Remove-Item C:\Users\$env:username\AppData\Local\Apps\2.0\* -recurse
