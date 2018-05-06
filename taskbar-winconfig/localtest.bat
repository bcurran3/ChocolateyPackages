@echo off
cpack
rem cinst taskbar-winconfig -s S:\ChocolateyPackagesDEV\taskbar-winconfig --params "'/TASKBAR:small /LOCATION:left /LOCK:no /PEOPLE:no /TASKVIEW:no /STORE:/no /INK:no /KEYBOARD:no /CORTANA:no'" -force
rem cinst taskbar-winconfig -s S:\ChocolateyPackagesDEV\taskbar-winconfig --params "'/TASKBAR:big /LOCATION:top /LOCK:YES /PEOPLE:YES /TASKVIEW:YES /STORE:/YES /INK:YES /KEYBOARD:YES /CORTANA:icon'" -force
rem cinst taskbar-winconfig -s S:\ChocolateyPackagesDEV\taskbar-winconfig --params "'/TASKBAR:big /LOCATION:bottom /LOCK:YES /PEOPLE:no /TASKVIEW:no /STORE:yes /INK:no /KEYBOARD:no /CORTANA:button'" -force
cinst taskbar-winconfig -s S:\ChocolateyPackagesDEV\taskbar-winconfig --params "'/STORE:yes /AUTOTRAY:yes'" -force
rem %1 will fail on install if null