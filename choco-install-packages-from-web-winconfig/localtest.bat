@echo off
cpack
choco install-packages-from-web-winconfig --params "'/ALLUSERS:YES'" -s S:\ChocolateyPackagesDEV\install-packages-from-web-winconfig\install-packages-from-web-winconfig.0.0.1.nupkg -force
