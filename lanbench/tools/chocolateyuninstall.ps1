$packageName= 'lanbench' 

if((get-process "LANBench" -ea SilentlyContinue) -eq $Null){ 
  echo "LANBench not running (Good!)." 
}
else{ 
  echo "Stopping LANBench before uninstalling."
  Stop-Process -processname "LANBench"
  Start-Sleep -s 2
}

Uninstall-ChocolateyZipPackage
remove-item "$env:Public\Desktop\LANBench.lnk" -Force -ErrorAction 'SilentlyContinue'
