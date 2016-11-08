$packageName = 'mfsr'

remove-item "$env:Public\Desktop\$packageName.lnk" -Force -ErrorAction 'SilentlyContinue'
