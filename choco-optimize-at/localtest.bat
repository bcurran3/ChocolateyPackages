@echo off
choco uninstall choco-optimize-at
cpack
rem cinst choco-optimize-at -s S:\ChocolateyPackages\choco-optimize-at
cinst choco-optimize-at -s S:\ChocolateyPackages\choco-optimize-at --params "'/WEEKLY:yes'"
rem %1 will fail on install if null