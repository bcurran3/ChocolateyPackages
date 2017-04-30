$packageName    = 'pelles-c'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "PellesCUninstall.ahk"

Start-Process $ahkExe $ahkFile
