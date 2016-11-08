$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
if ($is64bit) {
$unpath = "${Env:ProgramFiles}\Allway Sync\unins000.exe"
} else {
$unpath = "${Env:ProgramFiles (x86)}\Allway Sync\unins000.exe"
}
$packageName = 'allway-sync'
$softwareName = 'Allway Sync*'
$installerType = 'EXE' 
$silentArgs = '/VERYSILENT'
$validExitCodes = @(0, 3010, 1605, 1614, 1641)

Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes
