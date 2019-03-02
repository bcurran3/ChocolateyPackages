$ErrorActionPreference = 'Stop'
$packageName    = 'utorrent-webui'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Move-Item $toolsDir\webui.zip $ENV:AppData\uTorrent -Force
