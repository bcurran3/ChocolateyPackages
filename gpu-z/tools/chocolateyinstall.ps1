#https://www.techpowerup.com/download/techpowerup-gpu-z/
$packageName = 'gpu-z'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$PortableEXE = "$toolsDir\GPU-Z.$env:packageVersion.exe"

Remove-Item $ENV:ChocolateyInstall\bin\gpu-z*.exe # delete old shims
Remove-Item $toolsDir\*.exe -Exclude "GPU-Z.$env:packageVersion.exe" # deleted old versions kept by upgrade
Remove-Item $toolsDir\*.ignore -Exclude "GPU-Z.$env:packageVersion.exe.ignore" # delete old .ignore files (2.18.0+)
Write-Host "" | Out-File "$toolsDir\GPU-Z.$env:packageVersion.exe.ignore" # create .ignore file so shim isn't created

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\GPU-Z.lnk" -targetPath $PortableEXE
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath $PortableEXE
