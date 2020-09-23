$packageName = 'plexpy'

remove-item "$env:Public\Desktop\PlexPy.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PlexPy.lnk" -Force -ErrorAction 'SilentlyContinue'
