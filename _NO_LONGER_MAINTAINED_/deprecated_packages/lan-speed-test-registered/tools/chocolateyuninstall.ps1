$packageName = 'lan-speed-test-registered'
$softwareName = 'LAN Speed Test*'
$installerType = 'EXE' 
$silentArgs = '/VERYSILENT'
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
$processor = Get-WmiObject Win32_Processor

$is64bit = $processor.AddressWidth -eq 64
if ($is64bit) {
  $unpath = "${Env:ProgramFiles(x86)}\LAN Speed Test\unins000.exe"
  } else {
  $unpath = "${Env:ProgramFiles}\LAN Speed Test\unins000.exe"
  }

if((get-process "LAN_SpeedTest" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "LAN Speed Test currently NOT running. (Good!)" 
  }else{ 
    Write-Host "Stopping LAN_SpeedTest process..."
    Stop-Process -processname "LAN_SpeedTest"
  }

Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes
