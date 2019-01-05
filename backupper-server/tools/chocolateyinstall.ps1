$packageName    = 'backupper-server'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www2.aomeisoftware.com/download/adb/ABServer.exe'
$checksum       = '4071FECB9D161EBAE004F76FA91105F917EB3883C4A61B6216528484A3A7EA11'

if (!(Get-IsWinServer)) {
    Write-Warning "  ** This package is for Windows Server OSes only. Aborting."
  throw
  }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'AOMEI Backupper Server*' 
  checksum      = $checksum 
  checksumType  = 'sha256'  
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  
  validExitCodes= @(0,1)  
  }
Install-ChocolateyPackage @packageArgs

