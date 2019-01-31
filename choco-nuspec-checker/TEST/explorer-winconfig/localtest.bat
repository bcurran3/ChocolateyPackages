@echo off
choco uninstall explorer-winconfig 
cpack
rem cinst explorer-winconfig -s S:\ChocolateyPackages\explorer-winconfig --params "'/SHOWEXTENSIONS:yes /SHOWHIDDEN:all /SHOWCHECKBOXES:no /SHOWENCRYPTED:yes /SHOWPREVIEWPANE:no /USESHARINGWIZARD:no'" -force
cinst explorer-winconfig -s S:\ChocolateyPackages\explorer-winconfig --params "'/SHOWDRIVESNOMEDIA:no'" -force


rem showextentions - tested good win10+2012R2
rem showhidden - tested good win10+2012R2
rem showcheckboxes - tested good win10+2012R2
rem showencrypted - tested good win10+2012R2
rem USESHARINGWIZARD - tested good win10+2012R2
rem SHOWPREVIEWPANE - tested good win10+2012R2
rem SHOWDETAILSPANE - tested good win10+2012R2
rem SHOWFULLPATH - tested good win10+2012R2
REM SHOWDRIVESNOMEDIA - tested good win10
rem USEVIEW- tested good win10+2012R2
