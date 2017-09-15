$packageName    = 'backupper-server'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType  = 'EXE'
$url            = 'http://www.aomeisoftware.com/download/adb/ABServer.exe'
$checksum       = 'C51DA3805BF87D01B5F89722169B5A732F66D6AECC1E9E57A6E24715864945E7'
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

