$packageName    = 'nubasic' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$url            = ''
$checksum       = ''
$url64          = 'https://downloads.sourceforge.net/project/nubasic/binary/Windows/nubasic-ide-1.49-setup_x64.zip'
$checksum64     = 'AD6263B4AB714BBC9B6489FCF9D620E22D5A12D6E72B5E02052C3E79AB22B6EE'
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\nubasic-install.ahk"
$EXELocation    = "$toolsDir\setup-vs64.exe"

if ($bits -eq 32)
   {
    Write-Warning "Sorry, nuBASIC is 64 bit only." 
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
  file           = $EXELocation
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  softwareName   = 'nuBASIC*'
}

Start-Process $ahkExe $ahkFile
Write-Host "  ** Please wait up to 30 seconds to cancel Microsoft Visual C++ 2017 Redistributabe install." -foreground magenta
Write-Host "  ** Microsoft Visual C++ 2017 Redistributabe should already be installed as a dependency." -foreground magenta
 
Install-ChocolateyInstallPackage @packageArgs

remove-item $EXELocation -Force -ErrorAction 'SilentlyContinue'
