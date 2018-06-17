@echo off
choco uninstall explorer-winconfig 
cpack
rem cinst explorer-winconfig -s S:\ChocolateyPackages\explorer-winconfig --params "'/SHOWEXTENSIONS:yes /SHOWHIDDEN:all /SHOWCHECKBOXES:no /SHOWENCRYPTED:yes /SHOWPREVIEWPANE:no /USESHARINGWIZARD:no'" -force
cinst explorer-winconfig -s S:\ChocolateyPackages\explorer-winconfig --params "'/SHOWFULLPATH:yes'" -force


rem showextentions - tested good win10+2012
rem showhidden - tested good win10+2012
rem showcheckboxes - tested good win10+2012
rem showencrypted - tested good win10+2012
rem usepowershell - tested good win10
rem USESHARINGWIZARD - tested good win10
rem SHOWPREVIEWPANE - tested good win10+2012
rem SHOWDETAILSPANE - tested good win10+2012
rem SHOWFULLPATH - tested good win10

rem view - not working
