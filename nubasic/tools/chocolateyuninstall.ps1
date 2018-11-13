$packageName    = 'nubasic' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\nubasic-uninstall.ahk"

Start-Process $ahkExe $ahkFile
