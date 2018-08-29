$ErrorActionPreference = 'Stop'
$packageName  = 'burnttoast-psmodule'

Uninstall-Module -Name BurntToast -AllVersions -Force
