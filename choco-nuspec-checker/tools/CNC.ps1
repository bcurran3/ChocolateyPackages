# CNC.ps1 Copyleft 2018-2019 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

# REF: https://github.com/chocolatey/package-validator/wiki

function CNC-Splash{
Write-Host "CNC.ps1 v2019.01.09 - (unofficial) Chocolatey .nuspec Checker ""CNC - Run it through the Bill.""" -ForeGroundColor white
Write-Host "Copyleft 2018-2019 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use" -ForeGroundColor white
Write-Host
}

$AcceptableIconExts=@("png","svg")
$BinaryExtensions=@("*.exe","*.msi","*.zip","*.rar","*.7z","*.gz","*.tar","*.sfx","*.iso","*.img","*.msu","*.msp") # miss any?
$CDNlist     = "https://www.staticaly.com, https://raw.githack.com, https://gitcdn.link, or https://www.jsdelivr.com"
$CNCHeader   = "$ENV:ChocolateyInstall\bin\CNCHeader.txt"
$CNCFooter   = "$ENV:ChocolateyInstall\bin\CNCFooter.txt"

if (($args -eq "-help") -or ($args -eq "-?") -or ($args -eq "/?")) {
    CNC-Splash
    Write-Host "OPTIONS AND SWITCHES:" -ForeGround Magenta
	Write-Host
	Write-Host "-help, -?, or /?"
	Write-Host "   Displays this information."
	Write-Host "-AddFooter (saving not implemented yet)"
    Write-Host "   Adds a footer ($CNCFooter) to your .nuspec file and saves it."	
	Write-Host "-AddHeader (saving not implemented yet)"
    Write-Host "   Adds a header ($CNCHeader) to your .nuspec file and saves it."
	Write-Host "-EditFooter"
    Write-Host "   Edit $CNCFooter with Notepad."
	Write-Host "-EditHeader"
    Write-Host "   Edit $CNCHeader with Notepad."
	Write-Host "-OpenURLs"
    Write-Host "   Open all URLs in your browser for inspection when finished."
	Write-Host "-OpenValidatorInfo"
    Write-Host "   Open the Chocolatey package-validator info page on GitHub in your default browser."	
	Write-Host "-ShowFooter"
    Write-Host "   Displays $CNCFooter."	
	Write-Host "-ShowHeader"
    Write-Host "   Displays $CNCHeader."
	Write-Host "-UpdateImageURLs"
    Write-Host "   Updates image URLs with Staticaly CDN URLs."
	return
}

CNC-Splash

if ($args -eq "-EditFooter") {
    Write-Host "  ** Editing contents of $CNCFooter." -ForeGround Magenta
	&Notepad $CNCFooter
	return
}

if ($args -eq "-EditHeader") {
    Write-Host "  ** Editing contents of $CNCHeader." -ForeGround Magenta
	&Notepad $CNCHeader
	return
}

if ($args -eq "-ShowFooter") {
	Write-Host "  ** Displaying contents of $CNCFooter." -ForeGround Magenta
    Write-Host	
    Get-Content $CNCFooter
	return
}

if ($args -eq "-ShowHeader") {
    Write-Host "  ** Displaying contents of $CNCHeader." -ForeGround Magenta
    Write-Host	
    Get-Content $CNCHeader
	return
}

if ($args -eq "-OpenValidatorInfo") {
    Write-Host "  ** Opening https://github.com/chocolatey/package-validator/wiki." -ForeGround Magenta
    Write-Host	
    &start https://github.com/chocolatey/package-validator/wiki
	return
}

# Get and parse .nuspec in current directory
#FUTURE ENCHANCEMENT accept a filespec and use that as well
$LocalnuspecFile = Get-Item *.nuspec
if (!($LocalnuspecFile)) {
    Write-Warning "No .nuspec file found."
	return
   }
   
function Get-FileEncoding
# borrowed from https://blogs.technet.microsoft.com/samdrey/2014/03/26/determine-the-file-encoding-of-a-file-csv-file-with-french-accents-or-other-exotic-characters-that-youre-trying-to-import-in-powershell/
{
    [CmdletBinding()] Param (
     [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)] [string]$Path
    )

    [byte[]]$byte = get-content -Encoding byte -ReadCount 4 -TotalCount 4 -Path $Path

    if ( $byte[0] -eq 0xef -and $byte[1] -eq 0xbb -and $byte[2] -eq 0xbf )
    { Write-Output 'UTF8' }
    elseif ($byte[0] -eq 0xfe -and $byte[1] -eq 0xff)
    { Write-Output 'Unicode' }
    elseif ($byte[0] -eq 0 -and $byte[1] -eq 0 -and $byte[2] -eq 0xfe -and $byte[3] -eq 0xff)
    { Write-Output 'UTF32' }
    elseif ($byte[0] -eq 0x2b -and $byte[1] -eq 0x2f -and $byte[2] -eq 0x76)
    { Write-Output 'UTF7'}
    else
    { Write-Output 'ASCII' }
}

# Validate that URL elements are actually URLs and verify the URLs are good
function Validate-URL([string]$element,[string]$url){
if (($url -match "http://") -or ($url -match "https://")){
    $HTTP_Request = [System.Net.WebRequest]::Create("$url")
    $HTTP_Response = $HTTP_Request.GetResponse() # Can throw an error under certain conditions
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
$LicenseFile=(Get-ChildItem -Include *LICENSE*.txt -Recurse)
if ($LicenseFile){
	 Write-Host '           ** Binary files - '  $LicenseFile.Name ' file(s) found.' -ForeGround Green
	} else {
	 Write-Warning "           ** Binary files - LICENSE.txt file NOT found."
   }
}

function Check-VerificationFile{
$VerificationFile=(Get-ChildItem -Include *VERIFICATION*.txt -Recurse)
if ($VerificationFile){
     Write-Host '           ** Binary files - '  $VerificationFile.Name ' file(s) found.' -ForeGround Green
	} else {
	 Write-Warning "           ** Binary files - VERIFICATION.txt file NOT found."
   }
}

function Check-Binaries{
$IncludedBinaries=(Get-ChildItem -Include $BinaryExtensions -Recurse)
if ($IncludedBinaries){
    Write-Warning "  ** Binary files found in package. This will trigger a message from the verifier:"
    Write-Host '           ** Note: Binary files (.exe, .msi, .zip) have been included. The reviewer will ensure the maintainers have distribution rights. ' -ForeGround Cyan
	Check-LicenseFile
	Check-VerificationFile
   }
}

function Add-Header{
if (Test-Path $CNCHeader){
    $Header=(Get-Content $CNCHeader)
    $NuspecDescription=$Header+$NuspecDescription
    $UpdateNuspec=$True
	return $NuspecDescription
   } else {
	Write-Warning "           ** $CNCHeader not found."
   }
}

function Add-Footer{
if (Test-Path $CNCFooter){
    $Footer=(Get-Content $CNCFooter)
    $NuspecDescription=$NuspecDescription+$Footer
    $UpdateNuspec=$True
	return $NuspecDescription
   } else {
	Write-Warning "           ** $CNCFooter not found."
   }
}

function Check-Header{
# still needs to handle pre-pended spaces
if ($NuspecDescription.StartsWith("***") -or $NuspecDescription.StartsWith("---") -or $NuspecDescription.StartsWith("___")){ 
    Write-Host "           ** <description> - standardized header found." -ForeGround Green
	$HeaderFound=$True
   }
}

function Check-Footer{
# still needs to handle trailing spaces
if ($NuspecDescription.EndsWith("***") -or $NuspecDescription.EndsWith("---") -or $NuspecDescription.EndsWith("___")){
    Write-Host "           ** <description> - standardized footer found." -ForeGround Green
	$FooterFound=$True
   }
}

# Open all .nuspec URLs for viewing
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

# Convert RawGit and non-CDN URLs to Staticaly (and maybe others in the future)
function Update-CDNURL([string]$oldURL){
if ($oldURL -match 'https://raw.githubusercontent.com'){$StaticalyURL=($oldURL -replace 'https://raw.githubusercontent.com','https://cdn.staticaly.com/gh')}
if ($oldURL -match 'https://cdn.rawgit.com'){$StaticalyURL=($oldURL -replace 'https://cdn.rawgit.com','https://cdn.staticaly.com/gh')}
$UpdateNuspec=$True
Write-Host "           ** URL converted but saving not implemented yet." -ForeGround Red	
return $StaticalyURL
}

# FUTURE ENHANCEMENT load nuspec file and save changes
Function Update-nuspec{
if ($UpdateNuspec){
    Write-Host "Writing changes to $LocalnuspecFile." -ForeGround Magenta
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

$NuspecDisplayName=$LocalnuspecFile.Name

# Start outputting check results
Write-Host "CNC summary of $NuspecDisplayName :" -ForeGroundColor Magenta

# Open all .nuspec URLs for viewing if -OpenURLs is passed
if ($args -eq "-OpenURLs") {
    Write-Host "           ** Opening all .nuspec URLs in your default browser for viewing." -ForeGround Magenta
	Open-URLs
	}

# check for UTF8 encoding
$NuspecEncoding=(Get-FileEncoding -Path $LocalnuspecFile)
if ($NuspecEncoding -ne "UTF8"){Write-Warning "  ** $NuspecDisplayName is NOT UTF8 encoded."}

# <authors> checks
if (!($NuspecAuthors)) {Write-Warning "  ** <authors> element is empty, this element is a requirement."}

# <bugTrackerUrl> checks
if (!($NuspecBugTrackerURL)) {
     Write-Warning "  ** <bugTrackerUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: bugTrackerUrl - points to the location where issues and tickets can be accessed' -ForeGround Cyan
   } else {
     Validate-URL "<bugTrackerUrl>" $NuspecBugTrackerURL
	}

# <conflicts> checks - Built for the future
#if (!($NuspecConflicts)) {Write-Warning "  ** <conflicts> element is empty."}

# <copyright> checks
if (!($NuspecCopyright)) {
    Write-Warning "  ** <copyright> - element is empty."
	} else {
	  if ($NuspecCopyright.length -lt 5) {
	      Write-Warning "  ** <copyright> - Please update the copyright field so that it is using at least 4 characters."
		  }
	}

# <dependencies> checks
if (!($NuspecDependencies)) {Write-Warning "  ** <dependencies> - element is empty."}
if ((!$NuspecDependencies) -and ($NuspecTitle -match "deprecated")){Write-Warning "  ** <dependencies> - Deprecated packages must have a dependency."}

# ENHANCEMENT: (verifier message) The package takes a dependency on Chocolatey. The reviewer will ensure the package uses a specific Chocolatey feature that requires a minimum version. 

# <description> checks
if (!($NuspecDescription)) {
    Write-Warning "  ** <description> - element is empty, this element is a requirement."
   } else {
     if ($NuspecDescription.length -lt 30) {Write-Warning "  ** <description> - is less than 30 characters."}
     if ($NuspecDescription.length -gt 4000) {Write-Warning "  ** <description> - is greater than 4,000 characters."}
	 if ($NuspecDescription -match "raw.githubusercontent"){
         Write-Warning "  ** <description> - has a GitHub direct link. Please change to a CDN such as:"
         Write-Host "           ** $CDNlist" -ForeGround Cyan
#         Update-CDNURL - (need to parse and pass URL)
        }
     if ($NuspecDescription -match "cdn.rawgit.com"){
         Write-Warning "  ** <description> - RawGit CDN will be going offline October 2019. Please change to a CDN such as:"
         Write-Host "           ** $CDNlist" -ForeGround Cyan
#         Update-CDNURL - (need to parse and pass URL)
       }
	}
	
# ENHANCEMENT: (verifier message) Package contains dependencies with no specified version. You should at least specify a minimum version of a dependency. 
	
Check-Header
Check-Footer

# <docsUrl> checks
if (!($NuspecDocsURL)) {
    Write-Warning "  ** <docsUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: docsUrl - points to the location of the wiki or docs of the software' -ForeGround Cyan
   } else {
     Validate-URL "<docsUrl>" $NuspecDocsURL
	}

# <files> checks
if (!($NuspecFiles)) {Write-Warning "  ** <files> - element is empty."}

# <iconUrl> checks
if (!($NuspecIconURL)) {
    Write-Warning "  ** <iconUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Guideline: The iconUrl should be added if there is one. Please correct this in the nuspec, if applicable.' -ForeGround Cyan
   } else {
     Validate-URL "<iconUrl>" $NuspecIconURL
	 if ($NuspecIconURL -match "raw.githubusercontent"){
         Write-Warning "  ** <iconUrl> - Your package icon links directly to GitHub. Please use a CDN such as:"
         Write-Host "           ** $CDNlist" -ForeGround Cyan
         if ($args -eq "-UpdateImageURLs") {
		    $NewNuspecIconURL=(Update-CDNURL "$NuspecIconURL")
		   }
        }
     if ($NuspecIconURL -match "cdn.rawgit.com"){
        Write-Warning "  ** <iconUrl> - RawGit CDN will be going offline October 2019. Please change to a CDN such as:"
        Write-Host "           ** $CDNlist" -ForeGround Cyan
        if ($args -eq "-UpdateImageURLs") {
		    $NewNuspecIconURL=(Update-CDNURL "$NuspecIconURL")
		   }
       }
   }

$IconExt=($NuspecIconURL | Select-String -Pattern $AcceptableIconExts)
if (!($IconExt)){
    Write-Warning "  ** <iconUrl> - Suggestion: .PNG and .SVG are the preferred package icon file types." 
  }

# <id> checks
if (!($NuspecID)) {
    Write-Warning "  ** <id> - element is empty, this element is a requirement."
	} else {
     if ($NuspecID.length -gt 20) {
	     Write-Warning "  ** <id> - is greater than 20 characters. This will trigger a message from the verifier:"
	     Write-Host "           ** Note: If this is a new package that has never been approved, moderators will review and reject the`n              package for one that will be pushed with a new id that meets the package naming guidelines." -ForeGround Cyan
	    }
	 if ($NuspecID -cmatch "[A-Z]") {Write-Warning "  ** <id> - includes UPPERcase letters." }
	 if (($NuspecID -match ".") -and ($NuspecID -notmatch ".install") -and ($NuspecID -notmatch ".portable")) {
	      Write-Warning "  ** <id> - includes a '.'. This will trigger a message from the verifier:"
		  Write-Host "           ** Note: If this is a new package that has never been approved, moderators will review and reject the package`n              for one that will be pushed with a new id that meets the package naming guidelines."  -ForeGround Cyan
		 }
	 }

# <licenseUrl> checks
if (!($NuspecLicenseURL)) {
    Write-Warning "  ** <licenseUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host "           ** Guideline: The licenseUrl should be added if there is one. Please correct this in the nuspec,`n              if applicable." -ForeGround Cyan
   } else {
     Validate-URL "<licenseUrl>" $NuspecLicenseURL
	}	

# <mailingListUrl> checks
if (!($NuspecMailingListURL)) {
    Write-Warning "  ** <mailingListUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: mailingListUrl - points to the forum or email list group for the software' -ForeGround Cyan
   } else {
     Validate-URL "<mailingListUrl>" $NuspecMailingListURL
	}
	
# <owners> checks
if (!($NuspecOwners)) {
    Write-Warning "  ** <owners> element is empty, this element is a requirement."
   } else {
     if ($NuspecAuthors -eq $NuspecOwners){
        Write-Warning "  ** <owners> and <authors> elements are the same. This will trigger a message from the verifier:"
        Write-Host "           ** Note: The package maintainer field (owners) matches the software author field (authors) in the nuspec.`n              The reviewer will ensure that the package maintainer is also the software author." -ForeGround Cyan
		}
   }

# <packageSourceUrl> checks
if (!($NuspecPackageSourceURL)) {
    Write-Warning "  ** <packageSourceUrl> - element is empty."
	Write-Host "           ** Suggestion: Consider publishing your packages on GitHub. Other people might help you improve your package.`n              Users can also open issues to notify you of problems or updates." -ForeGround Cyan
   } else {
     Validate-URL "<packageSourceUrl>" $NuspecPackageSourceURL
	}		

# <projectSourceUrl> checks
if (!($NuspecProjectSourceURL)) {
    Write-Warning "  ** <projectSourceUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: projectSourceUrl - points to the location of the underlying software source' -ForeGround Cyan
   } else {
     Validate-URL "<projectSourceUrl>" $NuspecProjectSourceURL
	}
	
if ($NuspecProjectURL -eq $NuspecProjectSourceURL){
    Write-Warning "  ** <projectUrl> and <projectSourceUrl> elements are the same. This will trigger a message from the verifier:"
    Write-Host '           ** Guideline: ProjectUrl and ProjectSourceUrl are typically different, but not always. Please ensure that projectSourceUrl is pointing to software source code or remove the field from the nuspec.' -ForeGround Cyan
}

# <projectUrl> checks
if (!($NuspecProjectURL)) {
    Write-Warning "  ** <projectUrl> - element is empty, this element is a requirement."
   } else {
     Validate-URL "<projectUrl>" $NuspecProjectURL
	}	

# <provides> checks - Built for the future
#if (!($NuspecProvides)) {Write-Warning "  ** <provides> element is empty"}

# <releaseNotes> checks
if (!($NuspecReleaseNotes)) {
    Write-Warning "  ** <releaseNotes> element is empty. This will trigger a message from the verifier:"
	Write-Host "           ** Guideline: Release Notes (releaseNotes) are a short description of changes in each version of a package.`n              Please include releasenotes in the nuspec. NOTE: To prevent the need to continually update this field,`n              providing a URL to an external list of Release Notes is perfectly acceptable." -ForeGround Cyan
   }

# <replaces> checks - Built for the future
#if (!($NuspecReplaces)) {Write-Warning "  ** <replaces> element is empty."}

# <requireLicenseAcceptance> checks
if (!($NuspecRequireLicenseAcceptance)) {
    Write-Warning "  ** <requireLicenseAcceptance> - element is empty."
	} else {
	  if (($NuspecRequireLicenseAcceptance -eq "true") -and (!($NuspecLicenseURL))) {
	      Write-Warning "  ** <requireLicenseAcceptance> is set to true but <licenseUrl> is empty."
		  }
	  }

# <summary> checks
if (!($NuspecSummary)) {Write-Warning "  ** <summary> - element is empty."}

# <tags> checks
if (!($NuspecTags)) {
     Write-Warning "  ** <tags> - element is empty."
	} else {
	  if ($NuspecTags -match ","){
         Write-Warning "  ** <tags> - tags are separated with commas. They should only be separated with spaces."
		}
	  if ($NuspecTags -match "chocolatey"){
         Write-Warning "  ** Note: There is a tag named chocolatey. This will trigger a message from the verifier:"
         Write-Host '           ** Tags (tags) should not contain 'chocolatey' as a tag. Please remove that in the nuspec.' -ForeGround Cyan
		}
	  if ($NuspecTags -match "notsilent"){
         Write-Warning "  ** Note: There is a tag named notsilent. This will trigger a message from the verifier:"
         Write-Host '           ** Note: notSilent tag is being used. The reviewer will ensure this is being used appropriately. ' -ForeGround Cyan
		}		
    }

# <title> checks
if (!($NuspecTitle)) {Write-Warning "  ** <title> - element is empty, this element is a requirement."}

# <version> checks
if (!($NuspecVersion)) {Write-Warning "  ** <version> - element is empty, this element is a requirement."}

# Binaries checks
Check-Binaries

if ($args -eq "-AddHeader") {
$NewNuspecDescription=(Add-Header)
}

if ($args -eq "-AddFooter") {
$NewNuspecDescription=(Add-Footer)
}

Write-Host $NewNuspecDescription -ForeGround Green # temporary debugging

# FUTURE ENHANCEMENT update changes to nuspec
# Update-nuspec{
# $NewNuspecIconURL
# $NewNuspecDescription
#}

Write-Host "Found CNC.ps1 useful?" -ForeGroundColor white
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForeGroundColor white
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForeGroundColor white
return

# TDL
# show dependencies and version - Package contains dependencies with no specified version. You should at least specify a minimum version of a dependency. 
# check http links to see if https links are available and report if so
# option of displaying useful tips and tweaks (AutoHotKey, BeCyIconGrabber, PngOptimizer, Regshot, service viewer program, Sumo, etc)
# What else?