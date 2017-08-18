@echo off
cpack
cinst choco-upgrade-all-at -s S:\ChocolateyPackages\choco-upgrade-all-at --params "'/Time:%1'" -force
rem %1 will fail on install if null