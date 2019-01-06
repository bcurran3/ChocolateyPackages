# CNC.ps1 Copyleft 2018-2019 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

Write-Host
Write-Host "CNC.ps1 v2019.01.04 - (unofficial) Chocolatey .nuspec Checker ""CNC - Put it through the Bill.""" -ForegroundColor white
Write-Host "Copyleft 2018-2019 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use" -ForegroundColor white

$AcceptableIconExts=@("png","svg")
$BinaryExtensions=@("*.exe","*.msi","*.zip","*.rar","*.7z","*.gz","*.tar","*.sfx","*.iso","*.img","*.msu","*.msp") # miss any?
$CDNlist     = "https://www.staticaly.com, https://raw.githack.com, https://gitcdn.link, or https://www.jsdelivr.com"
$CNCHeader   = "$ENV:ChocolateyInstall\bin\CNCHeader.txt"
$CNCFooter   = "$ENV:ChocolateyInstall\bin\CNCFooter.txt"

# Get and parse .nuspec in current directory
#FUTURE ENCHANCEMENT accept a filespec and use that as well
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

function Check-LicenseFile{
$LicenseFile=(Get-ChildItem -Include LICENSE.txt -Recurse)
if ($LicenseFile){
     Write-Host "           ** Binary files - LICENSE.txt file found." -ForeGround Green
	} else {
	 Write-Warning "           ** Binary files - LICENSE.txt file NOT found."
   }
}

function Check-VerificationFile{
$VerificationFile=(Get-ChildItem -Include LICENSE.txt -Recurse)
if ($VerificationFile){
     Write-Host "           ** Binary files - VERIFICATION.txt file found." -ForeGround Green
	} else {
	 Write-Warning "           ** Binary files - VERIFICATION.txt file NOT found."
   }
}

function Check-Binaries{
$IncludedBinaries=(Get-ChildItem -Include $BinaryExtensions -Recurse)
if ($IncludedBinaries){
    Write-Warning "  ** Binary files found in package. This will trigger a message from the verifier:"
    Write-Host '           ** Binary files (.exe, .msi, .zip) have been included. The reviewer will ensure the maintainers have distribution rights. ' -ForeGround Cyan
	Check-LicenseFile
	Check-VerificationFile
   }
}

# FUTURE ENHANCEMENT to check for a standardized header
function Check-Header{
if ($NuspecDescription -match "'*'*'*"){ #This match doesn't work yet
    Write-Host "           ** <description> - standardized header found" -ForeGround Green
	$HeaderFound=$True
   }
}

# FUTURE ENHANCEMENT to check for a standardized footer
function Check-Footer{
if ($NuspecDescription -match "'*'*'*"){ #This match doesn't work yet
    Write-Host "           ** <description> - standardized footer found" -ForeGround Green
	$FooterFound=$True
   }
}

# FUTURE ENHANCEMENT to add a standardized header to the description
function Add-Header{
$NuspecDescription=(Get-Content $CNCHeader)+$NuspecDescription
$UpdateNuspec=$True
}

# FUTURE ENHANCEMENT to add a standardized footer to the description
function Add-Footer{
$NuspecDescription=$NuspecDescription+(Get-Content $CNCFooter)
$UpdateNuspec=$True
}

# FUTURE ENHANCEMENT to add a replace RawGit URLs with Staticaly(?) URLs
function Replace-RawGit{
$UpdateNuspec=$True
}

# FUTURE ENHANCEMENT to open all URLs to view
function Open-URLs{
if ($NuspecBugTrackerURL){&start $NuspecBugTrackerURL}
if ($NuspecDocsURL){&start $NuspecDocsURL}
if ($NuspecIconURL){&start $NuspecIconURL}
if ($NuspecLicenseURL){&start $NuspecLicenseURL}
if ($NuspecMailingListURL){&start $NuspecMailingListURL}
if ($NuspecPackageSourceURL){&start $NuspecPackageSourceURL}
if ($NuspecProjectSourceURL){&start $NuspecProjectSourceURL}
if ($NuspecProjectURL){&start $NuspecProjectURL}
}

# FUTURE ENHANCEMENT load nuspec file and save changes
Function Update-nuspec{
if ($UpdateNuspec){
    Write-Host "Writing changes to $LocalnuspecFile." -foreground magenta
    [xml]$Updatednuspec = Get-Content $LocalnuspecFile
# Need to determine changes then write out file
    $Updatednuspec.Save("$LocalnuspecFile")
	}
}

# Import package.nuspec file to get values
# FUTURE ENHANCEMENT change to function
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

Write-Host
Write-Host "CNC summary of "$LocalnuspecFile.Name":" -ForegroundColor Magenta
#Write-Host $NuspecSummary -foreground green

# <authors> checks
if (!($NuspecAuthors)) {Write-Warning "  ** <authors> element is empty, this element is a requirement."}

# <bugTrackerUrl> checks
if (!($NuspecBugTrackerURL)) {
     Write-Warning "  ** <bugTrackerUrl> - element is empty"
   } else {
     Validate-URL "<bugTrackerUrl>" $NuspecBugTrackerURL
	}

# <conflicts> checks
#if (!($NuspecConflicts)) {Write-Warning "  ** <conflicts> element is empty"} # Built for the future

# <copyright> checks
if (!($NuspecCopyright)) {Write-Warning "  ** <copyright> - element is empty"}

# <dependencies> checks
if (!($NuspecDependencies)) {Write-Warning "  ** <dependencies> - element is empty"}

# <description> checks
if (!($NuspecDescription)) {
    Write-Warning "  ** <description> - element is empty, this element is a requirement."
   } else {
     if ($NuspecDescription -match "cdn.rawgit.com"){
         Write-Warning "  ** <description> - RawGit CDN will be going offline October 2019. Please change to a CDN such as:"
         Write-Host "           ** $CDNlist" -ForeGround Cyan
       }
	}
	
#Check-Header

# <docsUrl> checks
if (!($NuspecDocsURL)) {
    Write-Warning "  ** <docsUrl> - element is empty"
   } else {
     Validate-URL "<docsUrl>" $NuspecDocsURL
	}

# <files> checks
if (!($NuspecFiles)) {Write-Warning "  ** <files> - element is empty"}

# <iconUrl> checks
if (!($NuspecIconURL)) {
    Write-Warning "  ** <iconUrl> - element is empty"
   } else {
     Validate-URL "<iconUrl>" $NuspecIconURL
	 if ($NuspecIconURL -match "raw.githubusercontent"){
         Write-Warning "  ** <iconUrl> - Your package icon links directly to GitHub. Please use a CDN such as:"
         Write-Host "           ** $CDNlist" -ForeGround Cyan
        }
     if ($NuspecIconURL -match "cdn.rawgit.com"){
        Write-Warning "  ** <iconUrl> - RawGit CDN will be going offline October 2019. Please change to a CDN such as:"
        Write-Host "           ** $CDNlist" -ForeGround Cyan
       }
   }

$IconExt=($NuspecIconURL | Select-String -Pattern $AcceptableIconExts)
if (!($IconExt)){
    Write-Warning "  ** <iconUrl> - .PNG and .SVG are the preferred package icon file types." 
  }

# <id> checks
if (!($NuspecID)) {Write-Warning "  ** <id> - element is empty, this element is a requirement."}

# <licenseUrl> checks
if (!($NuspecLicenseURL)) {
    Write-Warning "  ** <licenseUrl> - element is empty"
   } else {
     Validate-URL "<licenseUrl>" $NuspecLicenseURL
	}	

# <mailingListUrl> checks
if (!($NuspecMailingListURL)) {
    Write-Warning "  ** <mailingListUrl> - element is empty"
   } else {
     Validate-URL "<mailingListUrl>" $NuspecMailingListURL
	}
	
# <owners> checks
if (!($NuspecOwners)) {
    Write-Warning "  ** <owners> element is empty, this element is a requirement."
   } else {
     if ($NuspecAuthors -eq $NuspecOwners){
        Write-Warning "  ** <owners> and <authors> elements are the same. This will trigger a message from the verifier:"
        Write-Host '           ** The package maintainer field (owners) matches the software author field (authors) in the nuspec. The reviewer will ensure that the package maintainer is also the software author.' -ForeGround Cyan
		}
   }

# <packageSourceUrl> checks
if (!($NuspecPackageSourceURL)) {
    Write-Warning "  ** <packageSourceUrl> - element is empty"
   } else {
     Validate-URL "<packageSourceUrl>" $NuspecPackageSourceURL
	}		

# <projectSourceUrl> checks
if (!($NuspecProjectSourceURL)) {
    Write-Warning "  ** <projectSourceUrl> - element is empty"
   } else {
     Validate-URL "<projectSourceUrl>" $NuspecProjectSourceURL
	}
	
if ($NuspecProjectURL -eq $NuspecProjectSourceURL){
    Write-Warning "  ** <projectUrl> and <projectSourceUrl> elements are the same. This will trigger a message from the verifier:"
    Write-Host '           ** ProjectUrl and ProjectSourceUrl are typically different, but not always. Please ensure that projectSourceUrl is pointing to software source code or remove the field from the nuspec.' -ForeGround Cyan
}

# <projectUrl> checks
if (!($NuspecProjectURL)) {
    Write-Warning "  ** <projectUrl> - element is empty, this element is a requirement."
   } else {
     Validate-URL "<projectUrl>" $NuspecProjectURL
	}	

# <provides> checks
#if (!($NuspecProvides)) {Write-Warning "  ** <provides> element is empty"} # Built for the future

# <releaseNotes> checks
if (!($NuspecReleaseNotes)) {Write-Warning "  ** <releaseNotes> element is empty"}

# <replaces> checks
#if (!($NuspecReplaces)) {Write-Warning "  ** <replaces> element is empty"} # Built for the future

# <requireLicenseAcceptance> checks
if (!($NuspecRequireLicenseAcceptance)) {Write-Warning "  ** <requireLicenseAcceptance> - element is empty"}

# <summary> checks
if (!($NuspecSummary)) {Write-Warning "  ** <summary> - element is empty"}

# <tags> checks
if (!($NuspecTags)) {
     Write-Warning "  ** <tags> - element is empty"
	} else {
	  if ($NuspecTags -match "chocolatey"){
         Write-Warning "  ** There is a tag named chocolatey. This will trigger a message from the verifier:"
         Write-Host '           ** Tags (tags) should not contain 'chocolatey' as a tag. Please remove that in the nuspec.' -ForeGround Cyan
		}
    }

# <title> checks
if (!($NuspecTitle)) {Write-Warning "  ** <title> - element is empty, this element is a requirement."}

# <version> checks
if (!($NuspecVersion)) {Write-Warning "  ** <version> - element is empty, this element is a requirement."}

# Binaries checks
Check-Binaries

# FUTURE ENHANCEMENT ask to replace RawGit URLs
# Replace-RawGit

# FUTURE ENHANCEMENT ask to add header and/or footer
# Add-Header
# Add-Footer

# FUTURE ENHANCEMENT ask to view all URLs
# Open-URLs

# FUTURE ENHANCEMENT update changes to nuspec
# Update-nuspec

Write-Host
Write-Host "Found CNC.ps1 useful?" -ForegroundColor white
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor white
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor white
return

# TDL
# show dependencies and version - •	Package contains dependencies with no specified version. You should at least specify a minimum version of a dependency. 
# check http links to see if https links are available and report if so
# check description for > 4,000 characters and show cpack error
# What else?