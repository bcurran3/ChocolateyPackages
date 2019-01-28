<<<<<<< HEAD
﻿$packageName = 'choco-nuspec-checker' 
$script      = 'CNC.ps1'
$CNCHeader   = 'CNCHeader.txt'
$CNCFooter   = 'CNCFooter.txt'

Remove-Item "$ENV:ChocolateyInstall\bin\$script" -Force | Out-Null
Remove-Item "$ENV:ChocolateyInstall\bin\$CNCHeader" -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$ENV:ChocolateyInstall\bin\$CNCFooter" -Force -ErrorAction SilentlyContinue | Out-Null
=======
$packageName = 'choco-nuspec-checker' 
$script      = 'CNC.ps1'
$CNCHeader   = 'CNCHeader.txt'
$CNCFooter   = 'CNCFooter.txt'

Remove-Item "$ENV:ChocolateyInstall\bin\$script" -Force | Out-Null
Remove-Item "$ENV:ChocolateyInstall\bin\$CNCHeader" -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$ENV:ChocolateyInstall\bin\$CNCFooter" -Force -ErrorAction SilentlyContinue | Out-Null
>>>>>>> 569b2d7294411478d2ee52bfb07a69a9f3a90929
