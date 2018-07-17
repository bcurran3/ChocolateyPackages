# Checks for and throws install if $ProcessName is running
# Good for aborting installation of portable programs if they are running. Otherwise Chocolatey might think the package installed but you're still running the old version.

function Start-CheckandThrow($ProcessName){

if((Get-Process "$ProcessName" -ea SilentlyContinue) -eq $Null){ 
  }else{ 
    Write-Host "Aborting install due to $ProcessName is already running..." -foreground yellow
	Write-Host "Please quit the program and try the upgrade again." -foreground yellow
	throw
  }
}
