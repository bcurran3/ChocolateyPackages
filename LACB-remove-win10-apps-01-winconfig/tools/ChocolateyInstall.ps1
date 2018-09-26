$packageName = 'LACB-remove-win10-apps-01-winconfig'

#GAMES
# Anything by G5 Games, Hidden City Mystery of Shadows, etc.
Get-AppxPackage -allusers *828B5831.* | Remove-AppxPackage -ea SilentlyContinue
# Anything by king.com, i.e. CandyCrushSaga, CandyCrushSodaSaga, etc.
Get-AppxPackage -allusers *king.com* | Remove-AppxPackage -ea SilentlyContinue
Get-AppxPackage -allusers *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage -ea SilentlyContinue
Get-AppxPackage -allusers *XboxApp* | Remove-AppxPackage -ea SilentlyContinue

# MUSIC AND VIDEO
Get-AppxPackage -allusers *Microsoft.Windows.Photos* | Remove-AppxPackage -ea SilentlyContinue
Get-AppxPackage -allusers *Microsoft.ZuneMusic* | Remove-AppxPackage -ea SilentlyContinue
Get-AppxPackage -allusers *Microsoft.ZuneVideo* | Remove-AppxPackage -ea SilentlyContinue
Get-AppxPackage -allusers *Microsoft.Microsoft3DViewer* | Remove-AppxPackage -ea SilentlyContinue

# MISC MS STUFF
Get-AppxPackage -allusers *officehub* | Remove-AppxPackage -ea SilentlyContinue
#Get-AppxPackage -allusers *MicrosoftEdge* | Remove-AppxPackage -ea SilentlyContinue
Get-AppxPackage -allusers *Microsoft.People* | Remove-AppxPackage -ea SilentlyContinue
Get-AppxPackage -allusers *Microsoft.Windows.PeopleExperienceHost* | Remove-AppxPackage -ea SilentlyContinue
Get-AppxPackage -allusers *Microsoft.MicrosoftPowerBIForWindows* | Remove-AppxPackage -ea SilentlyContinue

# Mail
Get-AppxPackage -allusers *microsoft.windowscommunicationsapps* | Remove-AppxPackage -ea SilentlyContinue
# Microsoft Reality Portal
Get-AppxPackage -allusers *Microsoft.Windows.CloudExperienceHost* | Remove-AppxPackage -ea SilentlyContinue

# MISC
# Anything by Facebook
Get-AppxPackage -allusers *Facebook.* | Remove-AppxPackage -ea SilentlyContinue
# Anything by Twitter
Get-AppxPackage -allusers *9E2F88E3.* | Remove-AppxPackage -ea SilentlyContinue


# Microsoft.Advertising.Xaml ???
# Mixed Reality Portal see - https://winaero.com/blog/uninstall-mixed-reality-windows-10/
