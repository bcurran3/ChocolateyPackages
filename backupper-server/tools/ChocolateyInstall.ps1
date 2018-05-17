$packageName    = 'backupper-server'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType  = 'EXE'
$url            = 'http://www.aomeisoftware.com/download/adb/ABServer.exe'
$checksum       = '63223DCC3946C6275DBDD3E8AE45F36F448D3424264E6919ABF6420D6B13C913'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0,1)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "BUInstall.ahk"
$ServerOS       = (Get-WmiObject -class Win32_OperatingSystem).Caption
$Answer         = $ServerOS -match "Server"

if ($Answer -ne "True")
   {
    Write-Host "This package is for Windows Server OSes only. Aborting." -foreground red -backgroundcolor blue
	throw
   }

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  softwareName  = 'AOMEI Backupper Server*' 
  checksum      = $checksum 
  checksumType  = 'sha256'  
  silentArgs    = $silentArgs  
  validExitCodes= $validExitCodes  
  }
Install-ChocolateyPackage @packageArgs

