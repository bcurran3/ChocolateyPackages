@echo off
choco uninstall choco-upgrade-all-at-abort
cpack
cinst choco-upgrade-all-at-abort -s S:\ChocolateyPackages\choco-upgrade-all-at-abort
rem cinst choco-upgrade-all-at-abort -s S:\ChocolateyPackages\choco-upgrade-all-at-abort --params "'/ABORTTIME:01:00'"
rem %1 will fail on install if null