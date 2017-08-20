#$env:ChocolateyInstall\config\persistentpackages.config purposely not deleted as not to lose config on a re-installation
$packageName = 'choco-persistent-packages'

SchTasks /Delete /TN “choco-persistent-packages” /F

