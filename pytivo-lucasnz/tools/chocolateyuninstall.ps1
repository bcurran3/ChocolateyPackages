$packageName = 'pytivo-lucasnz'
$softwareName = 'PyTiVo-lucasnz*' 

Uninstall-ChocolateyZipPackage
remove-item "$env:Public\Desktop\PyTiVo.lnk" -Force -ErrorAction 'SilentlyContinue'
