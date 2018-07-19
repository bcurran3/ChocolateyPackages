# chocolatey-misc-helpers.extension v0.0.2 (07-19-2018) by Bill Curran - public domain
# Show-Patreon.ps1 - Displays a message and link to your Patreon account.
# If you define $global:packageMaintainer in your chocolateyinstall.ps1, 
# i.e. $global:packageMaintainer = 'BCURRAN3' it will use that too.
# Recommended to run this right before Install-ChocolateyPackage - that's when you MIGHT have a moment of the user's attention.
# Oh yeah! You can Patreon-ize me at https://www.patreon.com/bcurran3 :)

function Show-Patreon($PatreonURL){
Write-Host "-- While you're waiting for your package to install, consider becoming a patron of" -foreground cyan
if ($packageMaintainer) {
    Write-Host "-- $packageMaintainer, the maintainer of $env:packageName, at $PatreonURL" -foreground cyan
   } else {
    Write-Host "-- the maintainer of $env:packageName at $PatreonURL" -foreground cyan
   }
}