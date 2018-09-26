@echo off
choco uninstall chocolatey-preinstaller-checks.extension
cpack
cinst chocolatey-preinstaller-checks.extension.0.0.1-pre.nupkg
