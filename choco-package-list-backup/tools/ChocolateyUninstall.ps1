$packageName  = 'choco-package-list-backup' 
$script       = 'choco-package-list-backup.ps1'

$ScriptExists = (Test-Path $Env:USERPROFILE\Documents\WindowsPowerShell\$script)
if ($ScriptExists -eq "True")
   {
    Remove-Item $Env:USERPROFILE\Documents\WindowsPowerShell\$script | out-null
   } else{
    throw
	}

