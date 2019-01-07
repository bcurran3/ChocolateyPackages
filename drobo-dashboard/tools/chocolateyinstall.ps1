$ErrorActionPreference = 'Stop'
$packageName = 'drobo-dashboard' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe      = 'AutoHotKey'
$url         = 'http://files.drobo.com/webrelease/dashboard/Drobo-Dashboard-3.4.0.exe'
$checksum    = 'B5A303D9D02FC72AAC6FBD8B96269C512CE01161EA147D154CEED5AB6C0965C4'


$PreviouslyInstalled = (Test-Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{863885B3-7C05-421C-8817-568712778745}")
If ($PreviouslyInstalled -eq $True){
	Write-Host " ** Uninstalling previous version of Drobo Dashboard" -ForegroundColor Magenta
	Start-CheckandStop "Drobo Dashboard"
	Start-CheckandStop "DDAssist"

    $packageArgs = @{
      packageName   = $packageName
      fileType      = 'MSI' 
      silentArgs    = '{863885B3-7C05-421C-8817-568712778745}'
      softwareName  = 'Drobo Dashboard' 
    }

    $ahkFile = "$toolsDir\drobo-dashboard_uninstall.ahk" 
    Start-Process $ahkExe $ahkFile 
    Uninstall-ChocolateyPackage @packageArgs
}

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = ''
  softwareName  = 'Drobo Dashboard' 
  }

$ahkFile = "$toolsDir\drobo-dashboard_install.ahk"
Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs

If ($PreviouslyInstalled -eq $True){
   if ($ProcessWasRunning -eq "True") {&"$ProcessFullPath"}
   }
