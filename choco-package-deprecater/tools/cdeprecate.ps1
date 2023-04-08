param ([string]$Path=(Get-Location).path)
$ErrorActionPreference = 'Stop'
# cdeprecate.ps1 Copyleft 2019-2022 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

# REF: https://docs.microsoft.com/en-us/nuget/reference/nuspec
# REF: https://chocolatey.org/docs/how-to-deprecate-a-chocolatey-package
#
# REF: https://github.com/chocolatey/choco-wiki/issues/109
# REF: https://github.com/chocolatey/choco-wiki/issues/110

Write-Host "cdeprecate.ps1 v2022.03.15 - (unofficial) Chocolatey Package Deprecater/Retirer" -Foreground White
Write-Host "Copyleft 2019-2022 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$scriptDir      = "$env:ChocolateyToolsLocation\BCURRAN3"
$ScriptConfig   = 'cdeprecate.config'

# Verify ChocolateyToolsLocation was created by Get-ToolsLocation during install and is in the environment
If (!($env:ChocolateyToolsLocation)) {$env:ChocolateyToolsLocation = "$env:SystemDrive\tools"}

if (($args -eq '-help') -or ($args -eq '-?') -or (!$args)) {
    Write-Host "OPTIONS AND SWITCHES:" -Foreground Magenta
	Write-Host "-help, -?"
	Write-Host "   Displays this information."
	Write-Host "-Deprecate"
	Write-Host "   Deprecate the package."
	Write-Host "-Retire"
	Write-Host "   Retire the package."
	Write-Host "-AddDependency"
	Write-Host "   Not implemented yet."
	Write-Host "-AddIcon"
	Write-Host "   Add a fun icon instead of boring no icon."
	Write-Host "-EditConfig"
	Write-Host "   Edit cdeprecate config file."
	Write-Host "-OpenDeprecateDocs"
	Write-Host "   Opens https://chocolatey.org/docs/how-to-deprecate-a-chocolatey-package in your default browser."
	Write-Host
	return
}

# Setup conditions
if ($args -eq "-Deprecate") {$Deprecate=$True} else {$Deprecate=$False}
if ($args -eq "-Retire") {$Retire=$True} else {$Retire=$False}
if ($args -eq "-AddDependency") {$AddDependency=$True} else {$AddDependency=$False}
if ($args -eq "-AddIcon") {$AddIcon=$True} else {$AddIcon=$False}
if ($args -eq "-Debug") {$Debug=$True} else {$Debug=$False}
If (Test-Path $env:ChocolateyInstall\bin\notepad++.exe){$Editor="notepad++.exe" } else {$Editor="notepad.exe"}
If ($args -eq "-EditConfig") {
    Write-Host "  ** Editing contents of $ScriptConfig." -Foreground Magenta
	&$Editor "$scriptDir\$ScriptConfig"
	return
}
if ($args -eq "-OpenDeprecateDocs") {&Start-Process https://docs.chocolatey.org/en-us/community-repository/maintainers/deprecate-a-chocolatey-package ; return }


# Set default preferences incase of corrupt or missing cdeprecate.config
$DeprecatedDescription = '## This package has been deprecated. It has been replaced by the dependency shown below.'
$DeprecatedIconUrl     = 'https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/mylogos/deprecated.png'
$RetiredDescription    = '## This package has been retired.'
$RetiredIconUrl        = 'https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/mylogos/retired.png'

# Import preferences - see comments in cdeprecate.config for settings
If (Test-Path "$scriptDir\$ScriptConfig") {
   [xml]$ConfigFile       = Get-Content "$scriptDir\$ScriptConfig"
   $DeprecatedDescription = $ConfigFile.Settings.Preferences.DeprecatedDescription
   $DeprecatedIconUrl     = $ConfigFile.Settings.Preferences.DeprecatedIconUrl
   $RetiredDescription    = $ConfigFile.Settings.Preferences.RetiredDescription
   $RetiredIconUrl        = $ConfigFile.Settings.Preferences.RetiredIconUrl
   } else { 
   Write-Warning "   ** $ScriptConfig not found, using defaults."
   }

# Finds nuspec file for processing. Defaults to current working directory.
# You can specify a directory path, but do NOT specify the file itself, just the directory.
#if (!$path) {$LocalnuspecFile = Get-Item -Path $path\*.nuspec}
if ($path -eq "\"){$path=(Get-Location).Drive.Name + ":" + "\"}
if (!(Test-Path $path)){Write-Host "           ** $path is an invalid path." -Foreground Red; return}
if ($path) {$LocalnuspecFile = Get-Item $path\*.nuspec}
if (!($LocalnuspecFile)) {
    Write-Host "           ** No .nuspec file found in $path" -Foreground Red
	return
   }
if ($LocalnuspecFile.count -gt 1){
    Write-Host "           ** Multiple .nuspec files found in $path. Please delete or rename the extras." -Foreground Red
	return
   }

# Import package.nuspec file to get values
$nuspecXML = $LocalnuspecFile
[xml]$nuspecFile = Get-Content $nuspecXML
$NuspecAuthors = $nuspecFile.package.metadata.authors
$NuspecBugTrackerURL = $nuspecFile.package.metadata.bugtrackerurl	
#$NuspecConflicts = $nuspecFile.package.metadata.conflicts # Built for the future
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
#$NuspecProvides = $nuspecFile.package.metadata.provides # Built for the future
$NuspecReleaseNotes = $nuspecFile.package.metadata.releasenotes
#$NuspecReplaces = $nuspecFile.package.metadata.replaces # Built for the future
$NuspecRequireLicenseAcceptance = $nuspecFile.package.metadata.requireLicenseAcceptance
$NuspecSummary = $nuspecFile.package.metadata.summary
$NuspecTags = $nuspecFile.package.metadata.tags
$NuspecTitle = $nuspecFile.package.metadata.title
$NuspecVersion = $nuspecFile.package.metadata.version
#$NuspecXMLComment = $nuspecFile.'#comment'
#$NuspecXMLNamespace = $nuspecFile.package.xmlns

$NuspecDisplayName=$LocalnuspecFile.Name
$NuspecDisplayName=$NuspecDisplayName.ToUpper()

if ($debug){
	Write-Host "Path equals $path"
	Write-Host "LocalnuspecFile equals $LocalnuspecFile"
	Write-Host "nuspecXML equals $nuspecXML"
	Write-Host "NuspecTitle equals $NuspecTitle"
	Write-Host "nuspecFile.package.metadata.requireLicenseAcceptance equals $nuspecFile.package.metadata.requireLicenseAcceptance"
	Write-Host "NuspecRequireLicenseAcceptance equals $NuspecRequireLicenseAcceptance"
}

if ($deprecate) {Write-Host "Deprecating $NuspecDisplayName`:" -Foreground Magenta}
if ($retire){Write-Host "Retiring $NuspecDisplayName`:" -Foreground Magenta}

# Update the nuspec with changes and save as UTF-8 w/o BOM # Thanks https://stackoverflow.com/questions/8160613/powershell-saving-xml-and-preserving-format
Function Update-nuspec{
      $UpdatednuspecFile = [xml]([System.IO.File]::ReadAllText($LocalnuspecFile))
      $UpdatednuspecFile.PreserveWhitespace = $true
      $settings = New-Object System.Xml.XmlWriterSettings
      $settings.Indent = $true
      $settings.NewLineChars ="`r`n"
      $settings.Encoding = New-Object System.Text.UTF8Encoding($false)   

# Don't change:
#$UpdatednuspecFile.package.metadata.authors
#$UpdatednuspecFile.package.metadata.id
#$UpdatednuspecFile.package.metadata.owners
#$UpdatednuspecFile.package.metadata.packagesourceurl
#$UpdatednuspecFile.package.metadata.projecturl

# Changes
if ($NuspecBugTrackerURL) {$UpdatednuspecFile.package.metadata.bugtrackerurl=''}
if ($NuspecCopyright) {$UpdatednuspecFile.package.metadata.copyright=''}
if ($NuspecDependencies){
    if ($deprecate){
        $UpdatednuspecFile.package.metadata.dependencies='Add your superceding package here.'
       }
    if ($retire){
        $UpdatednuspecFile.package.metadata.dependencies=''
      }
   } else {
     if ($deprecate){
         Write-Host "  ** You need to add a dependency pointing to the replacement package." -Foreground Red
         Write-Host "  ** If there is no replacement package, then retire this package instead of deprecating it." -Foreground Red
        }
   }
if ($deprecate){$UpdatednuspecFile.package.metadata.description=$DeprecatedDescription}
if ($retire){$UpdatednuspecFile.package.metadata.description=$RetiredDescription}
if ($NuspecDocsURL){$UpdatednuspecFile.package.metadata.docsurl=''}
if ($NuspecIconURL){$UpdatednuspecFile.package.metadata.iconurl=''}
if ($deprecate -and $addicon){$UpdatednuspecFile.package.metadata.iconurl=$DeprecatedIconUrl}
if ($retire -and $addicon){$UpdatednuspecFile.package.metadata.iconurl=$RetiredIconUrl}
if ($NuspecLicenseURL) {$UpdatednuspecFile.package.metadata.licenseurl=''}
if ($NuspecRequireLicenseAcceptance) {$UpdatednuspecFile.package.metadata.requireLicenseAcceptance='false'}
if ($NuspecMailingListURL) {$UpdatednuspecFile.package.metadata.mailinglisturl=''}
if ($NuspecProjectSourceURL) {$UpdatednuspecFile.package.metadata.projectsourceurl=''}
if ($NuspecReleaseNotes) {$UpdatednuspecFile.package.metadata.releasenotes=''}
if ($NuspecSummary) {$UpdatednuspecFile.package.metadata.summary=''}
if ($NuspecTags){
     if ($deprecate){$UpdatednuspecFile.package.metadata.tags='deprecated'}
     if ($retire){$UpdatednuspecFile.package.metadata.tags='retired'}
    }
if ($NuspecTitle -notmatch "deprecated" -and $deprecate){$UpdatednuspecFile.package.metadata.title='[DEPRECATED] ' + $NuspecTitle}
if ($NuspecTitle -notmatch "retire" -and $retire){$UpdatednuspecFile.package.metadata.title='[RETIRED] ' + $NuspecTitle}
$UpdatednuspecFile.package.metadata.version='99.99.99.99'

#TDL: Need to handle <files> still          <<<<<<<<<<<<<---------------------------------------------------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#TDL: Need to handle <dependencies> still   <<<<<<<<<<<<<---------------------------------------------------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

      $xfile = [System.Xml.XmlWriter]::Create($LocalnuspecFile, $settings)
      try{
        $UpdatednuspecFile.Save($xfile)
      } finally {
        $xfile.Dispose()
      }
}

if ($deprecate -or $retire) {
    if (Test-Path $path\$LocalnuspecFile.cdeprecate.bak) {Write-Host "  ** Please delete your current backup before continuing." -Foreground Red ; break} # <<<-- doesn't work for some reason
    Copy-Item "$LocalnuspecFile" "$LocalnuspecFile.cdeprecate.bak" -Force | Out-Null # ALWAYS make backup copy!
    Write-Host "  ** Backup saved to $LocalnuspecFile.cdeprecate.bak." -Foreground Green
    Update-nuspec
	if ($retire){
	    if (!(Test-Path "$path\tools")) {New-Item -Path $path -Name "tools" -ItemType "directory" | Out-Null}
	    Write-Output 'Write-Host ""  ** This package has been retired."" -Foreground Magenta' | Out-File "$path\tools\chocolateyInstall.ps1"
	    }
	Write-Host "  ** Done!" -Foreground Green
	} else {
	  Write-Host "  ** Nothing done. You must specify -Deprecate or -Retire." -Foreground Magenta
	}


Write-Host "`nFound cdeprecate.ps1 useful?" -Foreground White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -Foreground White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -Foreground White
if (!(Test-Path "$ENV:ChocolateyToolsLocation\BCURRAN3\CNC.ps1")) {Write-Host "You need CNC! Get it at https://community.chocolatey.org/packages/choco-nuspec-checker" -Foreground Magenta }

#TDL
# create xml tags that don't exist; i.e. dependencies and files
# add superceding package as a parameter to create the dependency
# clean up pathing
