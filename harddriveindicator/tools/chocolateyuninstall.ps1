$packageName= 'harddriveindicator' 

if((get-process "HardDriveIndicator130" -ea SilentlyContinue) -eq $Null){ 
  echo "HardDriveIndicator130 not running." 
}
else{ 
  echo "Stopping HardDriveIndicator130 before uninstalling."
  Stop-Process -processname "HardDriveIndicator130"
  Start-Sleep -s 2
}

Uninstall-ChocolateyZipPackage
remove-item "$env:Public\Desktop\HardDriveIndicator.lnk" -Force -ErrorAction 'SilentlyContinue'
