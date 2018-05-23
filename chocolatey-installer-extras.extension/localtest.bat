@echo off
choco uninstall chocolatey-installer-extras.extension
cpack
cinst chocolatey-installer-extras.extension.0.0.1.nupkg
