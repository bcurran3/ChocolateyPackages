$packageName= 'ammyy-admin' 

if((get-process "AA_v3" -ea SilentlyContinue) -eq $Null){ 
  echo "Ammy Admin not running. (Good!)" 
}
else{ 
  echo "Stopping AA_v3 before uninstalling."
  Stop-Process -processname "AA_v3"
  Start-Sleep -s 2
}

Uninstall-ChocolateyZipPackage
remove-item "$env:Public\Desktop\Ammyy Admin.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Ammyy Admin.lnk" -Force -ErrorAction 'SilentlyContinue'
