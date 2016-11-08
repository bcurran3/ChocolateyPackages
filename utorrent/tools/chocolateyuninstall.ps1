$packageName = 'utorrent'
$installerType = 'EXE' 
$silentArgs = '/uninstall /S'
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
$unpath = "${Env:AppData}\uTorrent\uTorrent.exe"

if((get-process "utorrent" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "uTorrent currently NOT running." 
  }else{ 
    Write-Host "Stopping uTorrent process(es)..."
    Stop-Process -processname utorrent -force
  }

Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes

