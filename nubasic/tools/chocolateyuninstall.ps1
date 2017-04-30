$packageName    = 'nubasic' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "nuBASICUninstall.ahk"

Start-Process $ahkExe $ahkFile
