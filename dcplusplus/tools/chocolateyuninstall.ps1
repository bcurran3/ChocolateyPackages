$packageName = 'dcplusplus' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe      = 'AutoHotKey'
$ahkFile     = Join-Path $toolsDir "DCPPuninstall.ahk"

Start-Process $ahkExe $ahkFile

