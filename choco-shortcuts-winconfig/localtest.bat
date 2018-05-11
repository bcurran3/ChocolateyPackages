@echo off
choco uninstall choco-shortcuts-winconfig
cpack
cinst choco-shortcuts-winconfig -s S:\ChocolateyPackages\choco-shortcuts-winconfig
