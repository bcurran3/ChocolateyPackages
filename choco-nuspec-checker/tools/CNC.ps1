# CNC.ps1 Copyleft 2018 by Bill Curran AKA BCURRAN3

$CNCver        = "2018.12.28" # Version of this script
Write-Host
Write-Host "CNC.ps1 v$CNCver - (unofficial) Chocolatey .nuspec Checker ""CNC - Put it through the Bill.""" -ForegroundColor white
Write-Host "Copyleft 2018 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use" -ForegroundColor white

# Get and parse .nuspec in current directory
#ENCHANCEMENT: Should accept a filespec and use that as well
$LocalnuspecFile = Get-Item *.nuspec
if (!($LocalnuspecFile)) {
    Write-Warning "No .nuspec file found."
	return
   }

# Validate that URL elements are actually URLs and verify the URLs are good
function Validate-URL([string]$element,[string]$url){
if (($url -match "http://") -or ($url -match "https://")){
    $HTTP_Request = [System.Net.WebRequest]::Create("$url")
    $HTTP_Response = $HTTP_Request.GetResponse() 
    $HTTP_Status = [int]$HTTP_Response.StatusCode
	$HTTP_Response.Close()
    if ($HTTP_Status -eq 200) {
	   # do nothing, it's good!
       } else {
         Write-Warning "  ** $element - $url looks like a bad or non-responding URL, please check."
       }
  } else {
    Write-Warning "  ** $element - ""$url"" is not a valid URL"
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

# Report empty elements and misc possible oversights
Write-Host
Write-Host "CNC summary of "$LocalnuspecFile.Name":" -ForegroundColor Magenta
if (!($NuspecAuthors)) {Write-Warning "  ** <authors> element is empty, this element is a requirement."}
if (!($NuspecBugTrackerURL)) {
     Write-Warning "  ** <bugTrackerUrl> - element is empty"
   } else {
     Validate-URL "<bugTrackerUrl>" $NuspecBugTrackerURL
	}
#if (!($NuspecConflicts)) {Write-Warning "  ** <conflicts> element is empty"} # Built for the future
if (!($NuspecCopyright)) {Write-Warning "  ** <copyright> - element is empty"}
if (!($NuspecDependencies)) {Write-Warning "  ** <dependencies> - element is empty"}
if (!($NuspecDescription)) {Write-Warning "  ** <description> - element is empty, this element is a requirement."}
if (!($NuspecDocsURL)) {
    Write-Warning "  ** <docsUrl> - element is empty"
   } else {
     Validate-URL "<docsUrl>" $NuspecDocsURL
	}
if (!($NuspecFiles)) {Write-Warning "  ** <files> - element is empty"}
if (!($NuspecIconURL)) {
    Write-Warning "  ** <iconUrl> - element is empty"
   } else {
     Validate-URL "<iconUrl>" $NuspecIconURL
	}
if ($NuspecIconURL -match "raw.githubusercontent"){
    Write-Warning "  ** <iconUrl> - Your package icon links directly to GitHub. Please use a CDN such as:"
    Write-Host "              https://www.staticaly.com, https://raw.githack.com, or https://gitcdn.link." -ForeGround Cyan
  }
if ($NuspecIconURL -match "cdn.rawgit.com"){
    Write-Warning "  ** <iconUrl> - Your package icon uses RawGit CDN. It will be going offline in October 2019. Please change to a CDN such as:"
    Write-Host "              https://www.staticaly.com, https://raw.githack.com, or https://gitcdn.link." -ForeGround Cyan
  }  

$AcceptableIconExts=@("png","svg")
$IconExt=($NuspecIconURL | Select-String -Pattern $AcceptableIconExts)
if (!($IconExt)){
    Write-Warning "  ** <iconUrl> - .PNG and .SVG are the preferred package icon file types." 
  }

if (!($NuspecID)) {Write-Warning "  ** <id> - element is empty, this element is a requirement."}
if (!($NuspecLicenseURL)) {
    Write-Warning "  ** <licenseUrl> - element is empty"
   } else {
     Validate-URL "<licenseUrl>" $NuspecLicenseURL
	}	
if (!($NuspecMailingListURL)) {
    Write-Warning "  ** <mailingListUrl> - element is empty"
   } else {
     Validate-URL "<mailingListUrl>" $NuspecMailingListURL
	}		
if (!($NuspecOwners)) {Write-Warning "  ** <owners> element is empty, this element is a requirement."}
if (!($NuspecPackageSourceURL)) {
    Write-Warning "  ** <packageSourceUrl> - element is empty"
   } else {
     Validate-URL "<packageSourceUrl>" $NuspecPackageSourceURL
	}		
if (!($NuspecProjectSourceURL)) {
    Write-Warning "  ** <projectSourceUrl> - element is empty"
   } else {
     Validate-URL "<projectSourceUrl>" $NuspecProjectSourceURL
	}	
if (!($NuspecProjectURL)) {
    Write-Warning "  ** <projectUrl> - element is empty, this element is a requirement."
   } else {
     Validate-URL "<projectUrl>" $NuspecProjectURL
	}	
#if (!($NuspecProvides)) {Write-Warning "  ** <provides> element is empty"} # Built for the future
if (!($NuspecReleaseNotes)) {Write-Warning "  ** <releaseNotes> element is empty"}
#if (!($NuspecReplaces)) {Write-Warning "  ** <replaces> element is empty"} # Built for the future
if (!($NuspecRequireLicenseAcceptance)) {Write-Warning "  ** <requireLicenseAcceptance> - element is empty"}
if (!($NuspecSummary)) {Write-Warning "  ** <summary> - element is empty"}
if (!($NuspecTags)) {Write-Warning "  ** <tags> - element is empty"}
if (!($NuspecTitle)) {Write-Warning "  ** <title> - element is empty, this element is a requirement."}
if (!($NuspecVersion)) {Write-Warning "  ** <version> - element is empty, this element is a requirement."}

if ($NuspecAuthors -eq $NuspecOwners){
    Write-Warning "  ** <owners> and <authors> elements are the same. This will trigger a message from the verifier:"
    Write-Host 'The package maintainer field (owners) matches the software author field (authors) in the nuspec. The reviewer will ensure that the package maintainer is also the software author.' -ForeGround Cyan
}

if ($NuspecProjectURL -eq $NuspecProjectSourceURL){
    Write-Warning "  ** <projectUrl> and <projectSourceUrl> elements are the same. This will trigger a message from the verifier:"
    Write-Host 'ProjectUrl and ProjectSourceUrl are typically different, but not always. Please ensure that projectSourceUrl is pointing to software source code or remove the field from the nuspec.' -ForeGround Cyan
}

if ($NuspecTags -match "chocolatey"){
    Write-Warning "  ** There is a tag named chocolatey. This will trigger a message from the verifier:"
    Write-Host 'Tags (tags) should not contain 'chocolatey' as a tag. Please remove that in the nuspec.' -ForeGround Cyan
}

Write-Host
Write-Host "Found CNC.ps1 useful?" -ForegroundColor white
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor white
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor white
return

# TDL
# show dependencies and version - •	Package contains dependencies with no specified version. You should at least specify a minimum version of a dependency. 
# Check for common binary types and mention: binary files (.exe, .msi, .zip) have been included. The reviewer will ensure the maintainers have distribution rights. 
# What else?