$packageName= 'hfsexplorer'
$softwareName = 'HFSExplorer*' 
$installerType = 'EXE' 
$silentArgs = '/S' #Doesn't work
$validExitCodes = @(0)

$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
if ($is64bit) {
  $unpath = "${Env:ProgramFiles(x86)}\HFSExplorer\uninst.exe"
  } else {
  $unpath = "${Env:ProgramFiles}\HFSExplorer\uninst.exe"
  }


Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes