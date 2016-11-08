$packageName = 'ubooquity'
$softwareName = 'Ubooquity*' 

Uninstall-ChocolateyZipPackage
remove-item "$env:Public\Desktop\Ubooquity.lnk" -Force -ErrorAction 'SilentlyContinue'
