$packageName    = 'allway-sync'
$softwareName   = 'Allway Sync*'
$installerType  = 'EXE' 
$silentArgs     = '/VERYSILENT'
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
$processor      = Get-WmiObject Win32_Processor
$bits           = Get-ProcessorBits

if ($bits -eq 64)
  {
   $unpath = "${Env:ProgramFiles}\Allway Sync\unins000.exe" 
  } else {
   $unpath = "${Env:ProgramFiles (x86)}\Allway Sync\unins000.exe"
  }


Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes
