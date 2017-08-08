$packageName  = 'hppark' 
$shortcutName = 'HP PARK.lnk'

remove-item "$env:Public\Desktop\$shortcutName" -Force -ErrorAction 'SilentlyContinue'


