@echo off
cpack
cinst desktopicons-winconfig -s S:\ChocolateyPackages\desktopicons-winconfig --params "'/AllIcons:YES /RenameComputer:YES'" -force
rem %1 will fail on install if null