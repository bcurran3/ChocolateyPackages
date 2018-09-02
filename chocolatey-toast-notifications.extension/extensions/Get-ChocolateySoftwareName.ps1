# chocolatey-toast-notifications.extension v0.0.1 by Bill Curran AKA BCURRAN3 - 2018 public domain
# This function gets the name (title) of the software being installed from the package .nuspec file.

function Get-ChocolateySoftwareName{
$nuspecXML = "$env:ChocolateyInstall\lib\$env:chocolateyPackageName\$env:chocolateyPackageName.nuspec"

# Import title/softwareName
[xml]$nuspecFile = Get-Content $nuspecXML
$chocolateySoftwareName = $nuspecFile.package.metadata.title
return $chocolateySoftwareName
}
