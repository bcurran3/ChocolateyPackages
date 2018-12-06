# CNC.ps1 Copyleft 2018 by Bill Curran AKA BCURRAN3

$CNCver        = "0.0.1 (12/04/2018)" # Version of this script
Write-Host
Write-Host "CNC.ps1 v$CNCver - (unofficial) Chocolatey .nuspec Checker ""Put it through the Bill.""" -ForegroundColor white
Write-Host "Copyleft 2018 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use" -ForegroundColor white
Write-Host

$LocalnuspecFile = Get-Item *.nuspec
if (!($LocalnuspecFile)) {
    Write-Warning "No .nuspec file found."
	return
   }

# Validate that URL elements are actually URLs
function Validate-URL($url){
if (($url -match "http://") -or ($url -match "https://")){
   } else {
     Write-Warning "  ** $url is not a valid URL"
   }
}

# Import package.nuspec file to get values
$nuspecXML = $LocalnuspecFile
[xml]$nuspecFile = Get-Content $nuspecXML
$NuspecAuthors = $nuspecFile.package.metadata.authors
$NuspecBugTrackerURL = $nuspecFile.package.metadata.bugtrackerurl
$NuspecConflicts = $nuspecFile.package.metadata.conflicts # Built for the future
$NuspecCopyright = $nuspecFile.package.metadata.copyright
$NuspecDependencies = $nuspecFile.package.metadata.dependencies # Not fully implemented yet
$NuspecDescription = $nuspecFile.package.metadata.description
$NuspecDocsURL = $nuspecFile.package.metadata.docsurl
$NuspecFiles = $nuspecFile.package.files.file # Not fully implemented yet
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

# Report empty elements
Write-Host ""CNC summary of $LocalnuspecFile.Name:"" -ForegroundColor magenta
if (!($NuspecAuthors)) {Write-Warning "  ** <authors> element is empty, this element is a requirement."}
if (!($NuspecBugTrackerURL)) {
     Write-Warning "  ** <bugTrackerUrl> element is empty"
   } else {
     Validate-URL $NuspecBugTrackerURL
	}
#if (!($NuspecConflicts)) {Write-Warning "  ** <conflicts> element is empty"} # Built for the future
if (!($NuspecCopyright)) {Write-Warning "  ** <copyright> element is empty"}
if (!($NuspecDependencies)) {Write-Warning "  ** <dependencies> element is empty"}
if (!($NuspecDescription)) {Write-Warning "  ** <description> element is empty, this element is a requirement."}
if (!($NuspecDocsURL)) {
    Write-Warning "  ** <docsUrl> element is empty"
   } else {
     Validate-URL $NuspecDocsURL
	}
if (!($NuspecFiles)) {Write-Warning "  ** Files element is empty"}
if (!($NuspecIconURL)) {
    Write-Warning "  ** <iconUrl> element is empty"
   } else {
     Validate-URL $NuspecIconURL
	}
if (!($NuspecID)) {Write-Warning "  ** <id> element is empty, this element is a requirement."}
if (!($NuspecLicenseURL)) {
    Write-Warning "  ** <licenseUrl> element is empty"
   } else {
     Validate-URL $NuspecLicenseURL
	}	
if (!($NuspecMailingListURL)) {
    Write-Warning "  ** <mailingListUrl> element is empty"
   } else {
     Validate-URL $NuspecMailingListURL
	}		
if (!($NuspecOwners)) {Write-Warning "  ** <owners> element is empty"}
if (!($NuspecPackageSourceURL)) {
    Write-Warning "  ** <packageSourceUrl> element is empty"
   } else {
     Validate-URL $NuspecPackageSourceURL
	}		
if (!($NuspecProjectSourceURL)) {
    Write-Warning "  ** <projectSourceUrl> element is empty"
   } else {
     Validate-URL $NuspecProjectSourceURL
	}	
if (!($NuspecProjectURL)) {
    Write-Warning "  ** <projectUrl> element is empty"
   } else {
     Validate-URL $NuspecProjectURL
	}	
#if (!($NuspecProvides)) {Write-Warning "  ** <provides> element is empty"} # Built for the future
if (!($NuspecReleaseNotes)) {Write-Warning "  ** <releaseNotes> element is empty"}
#if (!($NuspecReplaces)) {Write-Warning "  ** <replaces> element is empty"} # Built for the future
if (!($NuspecRequireLicenseAcceptance)) {Write-Warning "  ** <requireLicenseAcceptance> element is empty"}
if (!($NuspecSummary)) {Write-Warning "  ** <summary> element is empty"}
if (!($NuspecTags)) {Write-Warning "  ** <tags> element is empty"}
if (!($NuspecTitle)) {Write-Warning "  ** <title> element is empty"}
if (!($NuspecVersion)) {Write-Warning "  ** <version> element is empty, this element is a requirement."}

Write-Host
