#From: Josh Fail <jfail@redhat.com> 
#Sent: Wednesday, August 15, 2018 1:30 PM
#To: Bill Curran <bcurran3@yahoo.com>
#Subject: Re: InstChoco license?
#
#This looks like a decent list and guide. Possibly out of date since the 1803 release of W10.
#https://www.askvg.com/guide-how-to-remove-all-built-in-apps-in-windows-10/
#
#My main interests are: 
#Get Office
#Paid Wi-Fi & Cellular
#OneNote
#Photoshop express
#PowerBI
#Eclipse Manager
$packageName = 'remove-win10-apps-redhat-group01'

Get-AppxPackage -allusers *officehub* | Remove-AppxPackage -ea SilentlyContinue
Get-AppxPackage -allusers *oneconnect* | Remove-AppxPackage -ea SilentlyContinue
Get-AppxPackage -allusers *onenote* | Remove-AppxPackage -ea SilentlyContinue
Get-AppxPackage -allusers *AdobePhotoshopExpress* | Remove-AppxPackage -ea SilentlyContinue
Get-AppxPackage -allusers *Microsoft.MicrosoftPowerBIForWindows* | Remove-AppxPackage -ea SilentlyContinue 
Get-AppxPackage *EclipseManager* | Remove-AppxPackage -ea SilentlyContinue
