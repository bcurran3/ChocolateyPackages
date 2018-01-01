$packageName = 'readycloud' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe      = 'AutoHotKey'
$ahkFile     = "$toolsDir\ReadyCLOUDuninstall.ahk"

Start-Process $ahkExe $ahkFile

Start-Sleep -s 20

