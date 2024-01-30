$ErrorActionPreference = 'Stop'
$packageName    = 'utorrent-webui'

Remove-Item $ENV:AppData\uTorrent\webui.zip -Force
