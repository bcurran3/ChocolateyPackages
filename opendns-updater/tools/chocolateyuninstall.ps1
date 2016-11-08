$packageName= 'opendns-updater'
$softwareName = 'OpenDNS Updater 2.2.1*' 
$installerType = 'EXE' 
$silentArgs = '/S' 
$validExitCodes = @(0)

$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
if ($is64bit) {
  $unpath = "${Env:ProgramFiles(x86)}\OpenDNS Updater\Uninstall.exe"
  } else {
  $unpath = "${Env:ProgramFiles}\OpenDNS Updater\Uninstall.exe"
  }

Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes