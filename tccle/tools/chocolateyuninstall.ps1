$ErrorActionPreference = 'Stop';
$packageName = 'tccle'
$softwareName = 'TCC LE*'
$installerType = 'EXE' 
$validExitCodes = @(0)
$processor = Get-WmiObject Win32_Processor

$is64bit = $processor.AddressWidth -eq 64
if ($is64bit) {
  $unpath = "${Env:ProgramData}\Caphyon\Advanced Installer\{55B12504-034B-47B5-8D76-8DB79F42CA21}\tcclex64.exe"
  $silentArgs = '/x {55B12504-034B-47B5-8D76-8DB79F42CA21} /quiet'
  } else {
  $unpath = "${Env:ProgramData}\Caphyon\Advanced Installer\{AD7FCD47-F681-47EB-85BB-295FBEB23922}\tccle.exe"
  $silentArgs = '/x {AD7FCD47-F681-47EB-85BB-295FBEB23922} /quiet'
  }

Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes



