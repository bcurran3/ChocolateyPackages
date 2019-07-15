$ErrorActionPreference = 'Stop'
$packageName    = 'nubasic' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$url64          = "$toolsDir\nubasic-ide-"+$ENV:ChocolateyPackageVersion+"-setup_x64.zip"
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\nubasic-install.ahk"
$EXELocation    = "$toolsDir\setup-vs64.exe"

if ($bits -eq 32)
   {
    Write-Warning "Sorry, nuBASIC is 64 bit only." 
    throw
   }

Get-ChocolateyUnzip -FileFullPath $url64 -Destination $toolsDir

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $EXELocation
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  softwareName   = 'nuBASIC*'
}

Start-Process $ahkExe $ahkFile
Write-Host "  ** Please wait up to 30 seconds to cancel Microsoft Visual C++ 2017 Redistributabe install." -Foreground Magenta
Write-Host "  ** Microsoft Visual C++ 2017 Redistributabe should already be installed as a dependency." -Foreground Magenta
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $url64 -Force -ErrorAction SilentlyContinue
Remove-Item $EXELocation -Force -ErrorAction SilentlyContinue
