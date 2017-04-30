$packageName    = 'drivermax'
$softwareName   = 'DriverMax*'
$installerType  = 'EXE' 
$silentArgs     = '/VERYSILENT'
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
$processor      = Get-WmiObject Win32_Processor

$is64bit = $processor.AddressWidth -eq 64
if ($is64bit) {
  $unpath = "${Env:ProgramFiles(x86)}\Innovative Solutions\DriverMax\unins000.exe"
} else {
  $unpath = "${Env:ProgramFiles}\Innovative Solutions\DriverMax\unins000.exe"
}

if((get-process "drivermax" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "drivermax currently NOT running." 
  }else{ 
    Write-Host "Stopping drivermax process..."
    Stop-Process -processname "drivermax"
  }

Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes
