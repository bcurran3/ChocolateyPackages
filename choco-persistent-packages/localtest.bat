@echo off
choco uninstall choco-persistent-packages
cpack
rem cinst choco-persistent-packages -s S:\ChocolateyPackages\choco-persistent-packages 
cinst choco-persistent-packages -s S:\ChocolateyPackages\choco-persistent-packages --params "'/TIME:01:00 /ABORTTIME:05:00'" -force
rem %1 will fail on install if null