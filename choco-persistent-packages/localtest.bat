@echo off
cpack
rem cinst choco-persistent-packages -s S:\ChocolateyPackages\choco-persistent-packages 
cinst choco-persistent-packages -s S:\ChocolateyPackages\choco-persistent-packages --params "'/Time:%1'" -force
rem %1 will fail on install if null