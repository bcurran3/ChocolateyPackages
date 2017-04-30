$packageName    = 'nubasic' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = ''
$checksum       = ''
$url64          = 'https://downloads.sourceforge.net/project/nubasic/binary/Windows/nubasic-ide-1.47-setup_x64.zip'
$checksum64     = '613718149246AFFF39E63F9F9B41AAF17A0BC1B79DBED1FC10695F020DBCB108'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$bits           = Get-ProcessorBits
$fileLocation   = Join-Path $toolsDir "setup-vs64.exe"
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "nuBASICInstall.ahk"

Start-Process $ahkExe $ahkFile

if ($bits -eq 32)
   {
    Write-Host "Sorry, nuBASIC is 64 bit only." -ForegroundColor red -BackgroundColor blue
    throw
   }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  url64         = $url64
  checksum64    = $checksum64
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'nuBASIC*'
}
 
Install-ChocolateyInstallPackage @packageArgs


  


