@echo off
cpack
cinst choco-upgrade-all-at -s S:\ChocolateyPackages\choco-persistent-packages
rem cinst choco-upgrade-all-at -s S:\ChocolateyPackages\choco-persistent-packages --params "'/Time:%1'" -force
rem %1 will fail on install if null