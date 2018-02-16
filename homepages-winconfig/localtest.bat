@echo off
cpack
choco install homepages-winconfig --params "'/ALL:NO /URL:www.chocolatey.org'" -s S:\ChocolateyPackagesDEV\homepages-winconfig\homepages-winconfig.0.0.1.nupkg -force
