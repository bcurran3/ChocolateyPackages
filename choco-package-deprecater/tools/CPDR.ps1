#$ErrorActionPreference = 'Stop'
# CPDR.ps1 Copyleft 2019 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

# REF: https://docs.microsoft.com/en-us/nuget/reference/nuspec
# REF: https://chocolatey.org/docs/how-to-deprecate-a-chocolatey-package
#
# REF: https://github.com/chocolatey/choco-wiki/issues/109
# REF: https://github.com/chocolatey/choco-wiki/issues/110

param (
    [string]$path=(Get-Location).path
 )

Write-Host "CPDR.ps1 v2019.09.02 - (unofficial) Chocolatey Package Deprecater/Retire-er" -Foreground White
Write-Host "Copyleft 2019 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

# parameters and variables -------------------------------------------------------------------------------------

$PSDefaultParameterValues['*:Encoding'] = 'utf8'

if (($args -eq '-help') -or ($args -eq '-?') -or (!$args)) {
    Write-Host "OPTIONS AND SWITCHES:" -Foreground Magenta
	Write-Host "-help, -?"
	Write-Host "   Displays this information."
	Write-Host "-Deprecate"
	Write-Host "   Deprecate the package."
	Write-Host "-Retire"
	Write-Host "   Retire the package."
	Write-Host "-AddIcon"
	Write-Host "   Fun icon instead of blank icon."
	Write-Host
	return
}

if ($args -eq "-Deprecate") {$Deprecate=$True} else {$Deprecate=$False}

if ($args -eq "-Retire") {$Retire=$True} else {$Retire=$False}

if ($args -eq "-AddIcon") {$AddIcon=$True} else {$AddIcon=$False}

if ($path -eq "\"){
    $path=(Get-Location).Drive.Name + ":" + "\"
}

if (!(Test-Path $path)){
    Write-Host "           ** $path is an invalid path." -Foreground Red
	return
   }

# Finds nuspec file for processing. Defaults to current working directory.
# You can specify a directory path, but do NOT specify the file itself, just the directory.
#if (!$path) {$LocalnuspecFile = Get-Item -Path $path\*.nuspec}
if ($path) {$LocalnuspecFile = Get-Item $path\*.nuspec}
if (!($LocalnuspecFile)) {
    Write-Host "           ** No .nuspec file found in $path" -Foreground Red
	return
   }
if ($LocalnuspecFile.count -gt 1){
    Write-Host "           ** Multiple .nuspec files found in $path. Please remove or rename the extras." -Foreground Red
	return
   }

Copy-Item "$LocalnuspecFile" "$LocalnuspecFile.CPDR.bak" -Force

# Import package.nuspec file to get values
$nuspecXML = $LocalnuspecFile
[xml]$nuspecFile = Get-Content $nuspecXML
$NuspecAuthors = $nuspecFile.package.metadata.authors
$NuspecBugTrackerURL = $nuspecFile.package.metadata.bugtrackerurl	
$NuspecConflicts = $nuspecFile.package.metadata.conflicts # Built for the future
$NuspecCopyright = $nuspecFile.package.metadata.copyright
$NuspecDependencies = $nuspecFile.package.metadata.dependencies
$NuspecDescription = $nuspecFile.package.metadata.description
$NuspecDocsURL = $nuspecFile.package.metadata.docsurl
$NuspecFiles = $nuspecFile.package.files.file
$NuspecIconURL = $nuspecFile.package.metadata.iconurl
$NuspecID = $nuspecFile.package.metadata.id
$NuspecLicenseURL = $nuspecFile.package.metadata.licenseurl
$NuspecMailingListURL = $nuspecFile.package.metadata.mailinglisturl
$NuspecOwners = $nuspecFile.package.metadata.owners
$NuspecPackageSourceURL = $nuspecFile.package.metadata.packagesourceurl
$NuspecProjectSourceURL = $nuspecFile.package.metadata.projectsourceurl
$NuspecProjectURL = $nuspecFile.package.metadata.projecturl
$NuspecProvides = $nuspecFile.package.metadata.provides # Built for the future
$NuspecReleaseNotes = $nuspecFile.package.metadata.releasenotes
$NuspecReplaces = $nuspecFile.package.metadata.replaces # Built for the future
$NuspecRequireLicenseAcceptance = $nuspecFile.package.metadata.requirelicenseacceptance
$NuspecSummary = $nuspecFile.package.metadata.summary
$NuspecTags = $nuspecFile.package.metadata.tags
$NuspecTitle = $nuspecFile.package.metadata.title
$NuspecVersion = $nuspecFile.package.metadata.version
$NuspecXMLComment = $nuspecFile.'#comment'
$NuspecXMLNamespace = $nuspecFile.package.xmlns

$NuspecDisplayName=$LocalnuspecFile.Name
$NuspecDisplayName=$NuspecDisplayName.ToUpper()
$ENV:ChocolateyPackageVersion=$NuspecVersion

if ($deprecate) {
    Write-Host "Deprecating $NuspecDisplayName" -Foreground Magenta
    }
if ($retire){
    Write-Host "Retiring $NuspecDisplayName" -Foreground Magenta
	}


# Update the nuspec with changes and save as UTF-8 w/o BOM
# Thanks https://stackoverflow.com/questions/8160613/powershell-saving-xml-and-preserving-format
Function Update-nuspec{
      $UpdatednuspecFile = [xml]([System.IO.File]::ReadAllText($LocalnuspecFile))
      $UpdatednuspecFile.PreserveWhitespace = $true
      $settings = New-Object System.Xml.XmlWriterSettings
      $settings.Indent = $true
      $settings.NewLineChars ="`r`n"
      $settings.Encoding = New-Object System.Text.UTF8Encoding($false)   
# changes
#$UpdatednuspecFile.package.metadata.authors
$UpdatednuspecFile.package.metadata.bugtrackerurl=''
#$UpdatednuspecFile.package.metadata.conflicts # Built for the future
$UpdatednuspecFile.package.metadata.copyright=''
if ($deprecate){
$UpdatednuspecFile.package.metadata.dependencies='Please edit this'
}
if ($retire){
$UpdatednuspecFile.package.metadata.dependencies=''
}
if ($deprecate){
$UpdatednuspecFile.package.metadata.description='##This package has been deprecated.`n ##It has been replaced by the dependency below.'
}
if ($retire){
$UpdatednuspecFile.package.metadata.description='##This package has been retired.'
}
if ($NuspecDocsURL){
$UpdatednuspecFile.package.metadata.docsurl=''
}
$UpdatednuspecFile.package.metadata.iconurl=''
if ($deprecate -and $addicon){
$UpdatednuspecFile.package.metadata.iconurl='https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/mylogos/deprecated.png'
}
if ($retire -and $addicon){
$UpdatednuspecFile.package.metadata.iconurl='https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/mylogos/retired.png'
}
#$UpdatednuspecFile.package.metadata.id
$UpdatednuspecFile.package.metadata.licenseurl=''
$UpdatednuspecFile.package.metadata.mailinglisturl=''
#$UpdatednuspecFile.package.metadata.owners
#$UpdatednuspecFile.package.metadata.packagesourceurl
$UpdatednuspecFile.package.metadata.projectsourceurl=''
#$UpdatednuspecFile.package.metadata.projecturl
#$UpdatednuspecFile.package.metadata.provides # Built for the future
$UpdatednuspecFile.package.metadata.releasenotes=''
#$UpdatednuspecFile.package.metadata.replaces # Built for the future
$UpdatednuspecFile.package.metadata.requirelicenseacceptance=''
$UpdatednuspecFile.package.metadata.summary=''
if ($deprecate){
$UpdatednuspecFile.package.metadata.tags='deprecated'
}
if ($retire){
$UpdatednuspecFile.package.metadata.tags='retired'
}
if ($deprecate){
$UpdatednuspecFile.package.metadata.title='[DEPRECATED] ' + $NuspecTitle
}
if ($retire){
$UpdatednuspecFile.package.metadata.title='[RETIRED] ' + $NuspecTitle
}
$UpdatednuspecFile.package.metadata.version='99.99.99.99'
$UpdatednuspecFile.package.files.file

      $xfile = [System.Xml.XmlWriter]::Create($LocalnuspecFile, $settings)
      try{
        $UpdatednuspecFile.Save($xfile)
      } finally {
        $xfile.Dispose()
      }
}

Update-nuspec

Write-Host "`nFound CPDR.ps1 useful?" -Foreground White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -Foreground White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -Foreground White

#TDL
# create tags that don't exist; i.e. dependencies
# create files tag if it doesn't exisit
#Create a chocolateyInstall.ps1 script that is either blank or simply has a Write-Host with the reason for retirement. (Necessary or you'll get a pack error of no content.)
