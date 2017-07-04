$packageName    = 'nubasic' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = ''
$checksum       = ''
$url64          = 'https://downloads.sourceforge.net/project/nubasic/binary/Windows/nubasic-ide-1.48-setup_x64.zip'
$checksum64     = '0FBBF1F68FA0778AC0176CDA9621AF350F957569E57C84C69061B76AC405F568'
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

remove-item $fileLocation -Force -ErrorAction 'SilentlyContinue'

  


