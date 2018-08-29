$ErrorActionPreference = 'Stop'
$packageName = 'iissecurity-psmodule'

Uninstall-Module -Name IISSecurity -Force
