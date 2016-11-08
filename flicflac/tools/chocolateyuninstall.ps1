$packageName = 'flicflac'
$softwareName = 'FlicFlac*' 

Uninstall-ChocolateyZipPackage
remove-item "$env:Public\Desktop\FlicFlac.lnk" -Force -ErrorAction 'SilentlyContinue'
