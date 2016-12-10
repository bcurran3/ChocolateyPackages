#work in progress - need to add AHK script

$packageName    = 'advanced-codecs'
$installerType  = 'EXE' 
$silentArgs     = '/SILENT'
$silentArgs2    = 'uninstall'
$validExitCodes = @(0)
$softwareName   = 'Shark007 ADVANCED Codecs*'
$unpath         = '${Env:ProgramFiles}\Shark007\unins000.exe'
$processor      = Get-WmiObject Win32_Processor
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "ACUninstall.ahk"

Start-Process $ahkExe $ahkFile

$is64bit = $processor.AddressWidth -eq 64
if ($is64bit) {
$unpath2 = '${Env:ProgramFiles(x86)}\Shark007\Advanced\Tools\Settings32.exe'
  } else {
$unpath2 = '${Env:ProgramFiles}\Shark007\Advanced\Tools\Settings32.exe'
  }

Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -File $unpath -validExitCodes $validExitCodes
Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs2 -File $unpath2 -validExitCodes $validExitCodes


#cmd /c start /D"C:\Program Files (x86)\Shark007\Advanced\Tools" Settings32.exe uninstall
