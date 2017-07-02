$packageName    = 'roost-desktop-notifier-for-nest' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://nest.richardeverett.com/notifierfornest/setup.exe' 
$checksum       = 'EE64F6CDDABD61525FF9B6A40C34C0A88BEC45985A4560440EE9F7687F3074EC'
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "RoostInstallWin10.ahk"

if((get-process "NotifierForNest" -ea SilentlyContinue) -eq $Null){ 
        Write-Host "NotifierForNest not running." -foreground "magenta" –backgroundcolor "blue"
}
else{ 
    Write-Host "Stopping NotifierForNest." -foreground "magenta" –backgroundcolor "blue"
    Stop-Process -processname "NotifierForNest"
	#Remove-Item C:\Users\%username%\AppData\Local\Apps\2.0\* -recurse
 }
 
# check for Windows 10
#[Environment]::OSVersion.Version -ge (new-object 'Version' 10,0)
# returns True or False 
 
$checkver = [Environment]::OSVersion.Version -lt (new-object 'Version' 8,0)
if ($checkver = "True")
     {
	   $ahkFile = Join-Path $toolsDir "RoostInstallpreWin10.ahk"
	 }

Start-Process $ahkExe $ahkFile
 
 $packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  silentArgs     = ''
  validExitCodes = $validExitCodes  
  softwareName   = 'Roost Desktop Notifier*'
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs

Start-Sleep -s 30

if((get-process "NotifierForNest" -ea SilentlyContinue) -eq $Null){ 
        Write-Host "NotifierForNest not running." -foreground "magenta" –backgroundcolor "blue"
}
else{ 
    Write-Host "Stopping NotifierForNest." -foreground "magenta" –backgroundcolor "blue"
    Stop-Process -processname "NotifierForNest"
	#Remove-Item C:\Users\%username%\AppData\Local\Apps\2.0\* -recurse
 }