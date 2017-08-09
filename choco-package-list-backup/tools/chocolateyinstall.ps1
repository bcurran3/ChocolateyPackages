$packageName  = 'choco-package-list-backup' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$script        = '$toolsDir\choco-package-list-backup.ps1'

$WPSDir = (Test-Path $Env:USERPROFILE\Documents\WindowsPowerShell)
if ($WPSDir -eq "True")
   {
    Move-Item $script $Env:USERPROFILE\Documents\WindowsPowerShell | out-null
   } else{
    throw
	}
