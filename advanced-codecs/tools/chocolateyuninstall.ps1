$packageName    = 'advanced-codecs'
$softwareName   = 'Shark007 ADVANCED Codecs*'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType  = 'EXE' 
$silentArgs     = '/SILENT'
$silentArgs2    = 'uninstall'
$validExitCodes = @(0)
$unpath         = "${Env:ProgramFiles}\Shark007\unins000.exe"
$bits           = Get-ProcessorBits
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "ACUninstall.ahk"

if ($bits -eq 64)
  {
   $unpath2 = "${Env:ProgramFiles(x86)}\Shark007\Advanced\Tools\Settings32.exe"  
  } else {
   $unpath2 = "${Env:ProgramFiles}\Shark007\Advanced\Tools\Settings32.exe"
  }

Start-Process $ahkExe $ahkFile

If (Test-Path $unpath){
Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -File $unpath -validExitCodes $validExitCodes
}Else{
}

Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs2 -File $unpath2 -validExitCodes $validExitCodes

