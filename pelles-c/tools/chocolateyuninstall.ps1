$ErrorActionPreference = 'Stop'
$packageName    = 'pelles-c'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\PellesCUninstall.ahk"

Start-Process $ahkExe $ahkFile
