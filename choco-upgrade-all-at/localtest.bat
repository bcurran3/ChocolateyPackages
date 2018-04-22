@echo off
choco uninstall choco-upgrade-all-at
cpack
cinst choco-upgrade-all-at -s S:\ChocolateyPackages\_DEV_\choco-upgrade-all-at
rem cinst choco-upgrade-all-at -s S:\ChocolateyPackages\_DEV_\choco-upgrade-all-at --params "'/WEEKLY:yes /Time:01:00'"
rem cinst choco-upgrade-all-at -s S:\ChocolateyPackages\_DEV_\choco-upgrade-all-at --params "'/WEEKLY:yes /DAY:WED /Time:23:00'"
rem cinst choco-upgrade-all-at -s S:\ChocolateyPackages\_DEV_\choco-upgrade-all-at --params "'/DAILY:yes'"
rem cinst choco-upgrade-all-at -s S:\ChocolateyPackages\_DEV_\choco-upgrade-all-at --params "'/DAILY:yes /Time:04:00'"
rem %1 will fail on install if null