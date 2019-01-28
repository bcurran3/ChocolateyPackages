<<<<<<< HEAD
﻿# CNC.ps1 Copyleft 2018-2019 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

# REF: https://docs.microsoft.com/en-us/nuget/reference/nuspec
# REF: https://github.com/chocolatey/package-validator/wiki

param (
    [string]$path=(Get-Location)
 )
 
Write-Host "CNC.ps1 v2019.01.27 - (unofficial) Chocolatey .nuspec Checker ""CNC - Run it through the Bill.""" -Foreground White
Write-Host "Copyleft 2018-2019 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

# variables ------------------------------------------------------------------------------------------------

$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$AcceptableIconExts=@("png","svg")
$BinaryExtensions=@("*.exe","*.msi","*.zip","*.rar","*.7z","*.gz","*.tar","*.sfx","*.iso","*.img","*.msu","*.msp","*.appx","*.appxbundle") # miss any?
$CDNlist     = "https://www.staticaly.com, https://raw.githack.com, https://gitcdn.link, or https://www.jsdelivr.com"
$CNCHeader   = "$ENV:ChocolateyInstall\bin\CNCHeader.txt"
$CNCFooter   = "$ENV:ChocolateyInstall\bin\CNCFooter.txt"
$global:UpdateNuspec=$False
$RunFrom=$pwd

if (($args -eq "-help") -or ($args -eq "-?") -or ($args -eq "/?")) {
    Write-Host "OPTIONS AND SWITCHES:" -Foreground Magenta
	Write-Host "-help, -?, or /?"
	Write-Host "   Displays this information."
	Write-Host "-AddFooter"
    Write-Host "   Adds and saves a footer from $CNCFooter to your <description>."	
	Write-Host "-AddHeader"
    Write-Host "   Adds and saves a header from $CNCHeader to your <description>."
	Write-Host "-EditFooter"
    Write-Host "   Edit $CNCFooter with Notepad++ or Notepad."
	Write-Host "-EditHeader"
    Write-Host "   Edit $CNCHeader with Notepad++ or Notepad."
	Write-Host "-OpenURLs"
    Write-Host "   Opens all URLs in your browser for inspection when finished."
	Write-Host "-OpenValidatorInfo"
    Write-Host "   Opens the Chocolatey package-validator info page on GitHub in your default browser."	
	Write-Host "-ShowFooter"
    Write-Host "   Displays $CNCFooter."	
	Write-Host "-ShowHeader"
    Write-Host "   Displays $CNCHeader."
	Write-Host "-Update"
    Write-Host "   Will re-write out your nuspec file; e.g. change to UTF-8 w/o BOM."
	Write-Host "-UpdateAll"
    Write-Host "   Same as -UpdateImageURLs with -UpdateXMLDeclaration."
	Write-Host "-UpdateImageURLs"
    Write-Host "   Updates image URLs with Staticaly CDN URLs."
	Write-Host "-UpdateXMLDeclaration"
    Write-Host "   Updates the XML declaration."
	Write-Host "-WhatIf"
    Write-Host "   Don't save changes."
	Write-Host "To check all your packages' .nuspec files: Change to the root directory of your packages and run (via PowerShell):" -Foreground Magenta
	Write-Host 'Get-ChildItem | ?{if ($_.PSIsContainer){cls;cd $_.Name;cnc;cd ..;pause}}' -Foreground Magenta
	return
}

if (Test-Path $ENV:ChocolateyInstall\bin\notepad++.exe){
     $Editor="notepad++.exe"
    } else {
      $Editor="notepad.exe"
    }

if ($args -eq "-EditFooter") {
    Write-Host "  ** Editing contents of $CNCFooter." -Foreground Magenta
	&$Editor $CNCFooter
	return
}

if ($args -eq "-EditHeader") {
    Write-Host "  ** Editing contents of $CNCHeader." -Foreground Magenta
	&$Editor $CNCHeader
	return
}

if ($args -eq "-ShowFooter") {
	Write-Host "  ** Displaying contents of $CNCFooter." -Foreground Magenta
    Write-Host	
    Get-Content $CNCFooter
	return
}

if ($args -eq "-ShowHeader") {
    Write-Host "  ** Displaying contents of $CNCHeader." -Foreground Magenta
    Write-Host	
    Get-Content $CNCHeader
	return
}

if ($args -eq "-OpenValidatorInfo") {
    Write-Host "  ** Opening https://github.com/chocolatey/package-validator/wiki." -Foreground Magenta
    Write-Host	
    &start https://github.com/chocolatey/package-validator/wiki
	return
}

if ($args -eq "-AddHeader") {
     $AddHeader=$True
   } else {
     $AddHeader=$False
}

if ($args -eq "-AddFooter") {
     $AddFooter=$True
   } else {
     $AddFooter=$False
}

if ($args -eq "-OpenURLs") {
     $OpenURLs=$True
   } else {
     $OpenURLs=$False
}

if ($args -eq "-UpdateImageURLs") {
     $UpdateImageURLs=$True
   } else {
     $UpdateImageURLs=$False
}

if ($args -eq "-UpdateXMLComment") {
     $UpdateXMLComment=$True
   } else {
     $UpdateXMLComment=$False
}

if ($args -eq "-UpdateXMLDeclaration") {
     $UpdateXMLDeclaration=$True
   } else {
     $UpdateXMLDeclaration=$False
}

if ($args -eq "-Update") {
	 $global:UpdateNuspec=$True
}

if ($args -eq "-UpdateAll") {
     $UpdateAll=$True
	 $UpdateImageURLs=$True
	 $UpdateXMLComment=$True
	 $UpdateXMLDeclaration=$True
	 $global:UpdateNuspec=$True
   } else {
     $UpdateAll=$False
}

if ($args -eq "-WhatIf") {
     $WhatIf=$True
   } else {
     $WhatIf=$False
}

if (!(Test-Path $path)){
    Write-Host "           ** $path is an invalid path." -Foreground Red
	return
   }

# Finds nuspec file for processing. Defaults to current working directory.
# You can specify a directory path, but do NOT specify the file itself, just the directory.
if (!$path) {$LocalnuspecFile = Get-Item ./*.nuspec}
if ($path) {$LocalnuspecFile = Get-Item $path\*.nuspec}
if (!($LocalnuspecFile)) {
    $CurrentDir=$path
    Write-Host "           ** No .nuspec file found in $pwd" -Foreground Red
	return
   }
if ($LocalnuspecFile.count -gt 1){
    Write-Host "           ** Multiple .nuspec files found in $pwd. Please remove or rename the extras." -Foreground Red
	return
   }

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

$NuspecDisplayName=$LocalnuspecFile.Name
$NuspecDisplayName=$NuspecDisplayName.ToUpper()

# functions ------------------------------------------------------------------------------------------------

# Borrowed and slightly modified from
# https://blogs.technet.microsoft.com/samdrey/2014/03/26/determine-the-file-encoding-of-a-file-csv-file-with-french-accents-or-other-exotic-characters-that-youre-trying-to-import-in-powershell/
# UTF-8 w/o BOM reports as ASCII. ASCII is a subset of UTF-8. 

function Get-FileEncoding
{
    [CmdletBinding()] Param (
     [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)] [string]$Path
    )

    [byte[]]$byte = get-content -Encoding byte -ReadCount 4 -TotalCount 4 -Path $Path

    if ($byte[0] -eq 0xef -and $byte[1] -eq 0xbb -and $byte[2] -eq 0xbf)
    { Write-Output 'UTF-8 w/ BOM' } 
    elseif ($byte[0] -eq 0xfe -and $byte[1] -eq 0xff)
    { Write-Output 'Unicode' }
    elseif ($byte[0] -eq 0 -and $byte[1] -eq 0 -and $byte[2] -eq 0xfe -and $byte[3] -eq 0xff)
    { Write-Output 'UTF-32' }
    elseif ($byte[0] -eq 0x2b -and $byte[1] -eq 0x2f -and $byte[2] -eq 0x76)
    { Write-Output 'UTF-7'}
    else
    { Write-Output 'ASCII or UTF-8 w/o BOM' } 
}

# Borrowed from
# https://web.archive.org/web/20160430132409/http://powershell.org:80/wp/forums/topic/how-to-check-syntax-of-scripts-automatically/
function Test-PowerShellSyntax
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string[]]
        $Path
    )

    process
    {
        foreach ($scriptPath in $Path) {
            $contents = Get-Content -Path $scriptPath

            if ($null -eq $contents)
            {
                continue
            }

            $errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)

            New-Object psobject -Property @{
                Path = $scriptPath
                SyntaxErrorsFound = ($errors.Count -gt 0)
            }
        }
    }
}

# Validate that URL elements are actually URLs and verify the URLs are good
# Thanks https://stackoverflow.com/questions/23760070/the-remote-server-returned-an-error-401-unauthorized
function Validate-URL([string]$element,[string]$url){
if (($url -match "http://") -or ($url -match "https://")){
     $HTTP_Response = $null
     $HTTP_Request = [System.Net.WebRequest]::Create($url)
     try{
         $HTTP_Response = $HTTP_Request.GetResponse()
         $HTTP_Status = [int]$HTTP_Response.StatusCode
         if ($HTTP_Status -eq 200) { 
            # do nothing, it's good!
         } else {
           Write-Host ("  ** $element - $url site might be OK, status code:" + $HTTP_Status)
		   Write-Host "           ** Consider using CNC's -OpenURLs option to open and view all URLs in the .nuspec." -Foreground Cyan
         }
         $HTTP_Response.Close()
        } catch {
          $HTTP_Status = [regex]::matches($_.exception.message, "(?<=\()[\d]{3}").Value
          Write-Warning ("  ** $element - ""$url"" is probably bad, status code: " + $HTTP_Status)
          Write-Host "           ** Consider using CNC's -OpenURLs option to open and view all URLs in the .nuspec." -Foreground Cyan
        }
   }
}

# Check for license files when binaries are included
function Check-LicenseFile{
$LicenseFile=(Get-ChildItem -Path $path -Include *LICENSE* -Recurse)
if ($LicenseFile){
	 Write-Host '           ** Binary files - '  $LicenseFile.Name ' file(s) found.' -Foreground Green
	} else {
	 Write-Warning "  ** Binary files - LICENSE.txt file NOT found."
   }
}

# Check for verification file when binaries are included
function Check-VerificationFile{
$VerificationFile=(Get-ChildItem -Path $path -Include *VERIFICATION* -Recurse)
if ($VerificationFile){
     Write-Host '           ** Binary files - '  $VerificationFile.Name ' file(s) found.' -Foreground Green
	} else {
	 Write-Warning "  ** Binary files - VERIFICATION.txt file NOT found."
   }
}

# check for binaries
function Check-Binaries{
$IncludedBinaries=(Get-ChildItem -Path $path -Include $BinaryExtensions -Recurse)
if ($IncludedBinaries){
    Write-Warning "  ** Binary files found in package. This will trigger a message from the verifier:"
    Write-Host "           ** Note: Binary files (.exe, .msi, .zip) have been included. The reviewer will ensure the maintainers have`n              distribution rights." -Foreground Cyan
	Check-LicenseFile
	Check-VerificationFile
   }
}

# add header template to <description>
function Add-Header{
if (Test-Path $CNCHeader){
    $Header=[IO.File]::ReadAllText($CNCHeader)
    $NuspecDescription="`n" + $Header + $NuspecDescription
    Write-Host "           ** <description> - added header template." -Foreground Green
	$global:UpdateNuspec=$True
	return $NuspecDescription
   } else {
	Write-Warning "           ** $CNCHeader not found."
   }
}

# add footer template to <description>
function Add-Footer{
if (Test-Path $CNCFooter){
    $Footer=[IO.File]::ReadAllText($CNCFooter)
    $NuspecDescription=$NuspecDescription + "`n" + $Footer
    Write-Host "           ** <description> - added footer template." -Foreground Green
    $global:UpdateNuspec=$True
	return $NuspecDescription
   } else {
	Write-Warning "           ** $CNCFooter NOT found."
   }
}

# check if header template is already in the description
function Check-Header{
$NuspecDescription=$NuspecDescription.Trim()
if ($NuspecDescription.StartsWith("***") -or $NuspecDescription.StartsWith("---") -or $NuspecDescription.StartsWith("___")){ 
    Write-Host "           ** <description> - header template found." -Foreground Green
   }
}

# check if footer template is already in the description
function Check-Footer{
$NuspecDescription=$NuspecDescription.Trim()
if ($NuspecDescription.EndsWith("***") -or $NuspecDescription.EndsWith("---") -or $NuspecDescription.EndsWith("___")){
    Write-Host "           ** <description> - footer template found." -Foreground Green
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
$global:UpdateNuspec=$True
return $StaticalyURL
}

# Update the nuspec XML comment with encoding test
function Update-XMLComment{
Write-Host "           ** -UpdateXMLComment still under construction." -Foreground Red
#Write-Host "           ** XML UTF-8 encoding test comment added." -Foreground Green
#$nuspecFile.'#comment' = "Do not remove this test for UTF-8: if `“Ω`” doesn`’t appear as greek uppercase omega letter enclosed in quotation marks, you should use an editor that supports UTF-8, not this one."
#$global:UpdateNuspec=$True
}

# Update the nuspec XML declaration with encoding info
function Update-XMLDeclaration{
Write-Host "           ** XML declaration changed to version=""1.0"" encoding=""utf-8""" -Foreground Green
$nuspecFile.xml="version=""1.0"" encoding=""utf-8"""
$global:UpdateNuspec=$True
}

# Update the nuspec with any changes and save as UTF-8 w/o BOM
# Thanks https://stackoverflow.com/questions/8160613/powershell-saving-xml-and-preserving-format
Function Update-nuspec{
if ($global:UpdateNuspec){
   if ($WhatIf){
        Write-Host "CNC did NOT update $LocalnuspecFile, -WhatIf parameter was used." -Foreground Magenta
		return
   }
   $UpdatednuspecFile = [xml]([System.IO.File]::ReadAllText($LocalnuspecFile))
   $UpdatednuspecFile.PreserveWhitespace = $true
   $settings = New-Object System.Xml.XmlWriterSettings
   $settings.Indent = $true
   $settings.NewLineChars ="`r`n"
   $settings.Encoding = New-Object System.Text.UTF8Encoding($false)   

   # changes
#   if ($nuspecFile.'#comment'){$UpdatednuspecFile.'#comment' = $nuspecFile.'#comment'} # throws error
   if ($nuspecFile.xml){$UpdatednuspecFile.xml = $nuspecFile.xml}
   if ($NuspecDescription){$UpdatednuspecFile.package.metadata.description=[string]$NuspecDescription}
   if ($NuspecIconURL){$UpdatednuspecFile.package.metadata.iconurl=$NuspecIconURL}

   $xfile = [System.Xml.XmlWriter]::Create($LocalnuspecFile, $settings)
   try{
     $UpdatednuspecFile.Save($xfile)
    } finally {
     $xfile.Dispose()
    }
   Write-Host "CNC updated $LocalnuspecFile." -Foreground Magenta
  }
}

# Start outputting check results
Write-Host "CNC Summary of $NuspecDisplayName :" -Foreground Magenta

# Open all .nuspec URLs for viewing if -OpenURLs is passed
if ($OpenURLs) {
    Write-Host "           ** Opening all .nuspec URLs in your default browser for viewing." -Foreground Magenta
	Open-URLs
	}
	
# checks ------------------------------------------------------------------------------------------------

# check for UTF8 encoding
# UTF-8 w/BOM is not desired per "You must save your files with UTF–8 character encoding without BOM."
$NuspecEncoding=(Get-FileEncoding -Path $LocalnuspecFile)
if ($NuspecEncoding -ne 'ASCII or UTF-8 w/o BOM'){
    Write-Warning "  ** $NuspecDisplayName is encoded using $NuspecEncoding."
	if ($global:UpdateNuspec) {
	     Write-Host "           ** $NuspecDisplayName will be converted to UTF-8 w/o BOM and saved." -Foreground Green
		 } else {
		   Write-Host "           ** You must save your files with UTF–8 character encoding without BOM." -Foreground Cyan
		   Write-Host "           ** Consider running CNC -Update to re-write`n              $LocalnuspecFile to UTF-8 w/o BOM." -Foreground Cyan
	}
}

# check XML declaration
if ($nuspecFile.xml -eq "version=""1.0"""){
    Write-Warning "  ** XML declaration is version=""1.0"""
	if ($UpdateXMLDeclaration){
	    Update-XMLDeclaration
	} else {
      Write-Host "           ** Consider running CNC -UpdateXMLDeclaration to add a UTF-8 encoding statement." -Foreground Cyan
	}
}

# check XML comment
if (!$nuspecFile.'#comment'){
#$PSDefaultParameterValues['*:Encoding'] = 'utf8'
    Write-Warning "  ** The recommended UTF-8 encoding check comment was not found."
	if ($UpdateXMLComment){
	    Update-XMLComment
	} else {
      Write-Host "           ** Consider running CNC -UpdateXMLComment to add a UTF-8 encoding check comment." -Foreground Cyan
   }
}

# <authors> checks
if (!($NuspecAuthors)) {
    Write-Host "           ** <authors> element is empty, this element is a requirement." -Foreground Red
   } else {
     if ($NuspecAuthors -match "@"){
	     Write-Warning "  ** <authors> - contains an e-mail address. This will trigger a message from the verifier:"
	     Write-Host '           ** Requirements: Email address should not be used in the Author and Copyright fields of the nuspec file. ' -Foreground Cyan
	 }
   }

# <bugTrackerUrl> checks
if (!($NuspecBugTrackerURL)) {
     Write-Warning "  ** <bugTrackerUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: bugTrackerUrl - points to the location where issues and tickets can be accessed' -Foreground Cyan
   } else {
     Validate-URL "<bugTrackerUrl>" $NuspecBugTrackerURL
	}

# <conflicts> checks - Built for the future
#if (!($NuspecConflicts)) {Write-Warning "  ** <conflicts> element is empty."}

# <copyright> checks
if (!($NuspecCopyright)) {
    Write-Warning "  ** <copyright> - element is empty."
	} else {
	  if ($NuspecCopyright.Length -lt 5) {
	      Write-Warning "  ** <copyright> - Please update the copyright field so that it is using at least 4 characters."
		  }
	  if ($NuspecAuthors -match "@"){
	      Write-Warning "  ** <copyright> - contains an e-mail address. This will trigger a message from the verifier:"
	      Write-Host '           ** Requirements: Email address should not be used in the Author and Copyright fields of the nuspec file. ' -Foreground Cyan
	 }
	}

# <dependencies> checks
if (!($NuspecDependencies)) {
    Write-Warning "  ** <dependencies> - element is empty."
   } else {
     if ((!$NuspecDependencies) -and ($NuspecTitle -match "deprecated")){Write-Warning "  ** <dependencies> - Deprecated packages must have a dependency."}
	 if ($NuspecDependencies.dependency.id -eq 'chocolatey'){
	     Write-Warning "  ** <dependencies> - ""chocolatey"" is a dependency. This will trigger a message from the verifier:"
	     Write-Host "           ** Note: The package takes a dependency on Chocolatey. The reviewer will ensure the package uses a specific`n              Chocolatey feature that requires a minimum version." -Foreground Cyan
		 }
	 $DependencyName=$NuspecDependencies.dependency.id
	 if ($NuspecDependencies.dependency.id.count -eq 1){
    	 if ($NuspecDependencies.dependency.version -eq $null){
	          Write-Warning "  ** <dependencies> - $DependencyName has no version. This will trigger a message from the verifier:"
      	      Write-Host "           ** Guideline: Package contains dependencies with no specified version. You should at least specify`n              a minimum version of a dependency." -Foreground Cyan
	         }
	 } else {
	   $DependencyNumber=0
	 do{
	    $DependencyName=$NuspecDependencies.dependency.id[$DependencyNumber]
 	    if ($NuspecDependencies.dependency[$DependencyNumber].version -eq $null){
				Write-Warning "  ** <dependencies> - ""$DependencyName"" has no version. This will trigger a message from the verifier:"
			    Write-Host "           ** Guideline: Package contains dependencies with no specified version. You should at least specify`n              a minimum version of a dependency." -Foreground Cyan
			}
	   $DependencyNumber++
       } while ($DependencyNumber -lt $NuspecDependencies.dependency.id.count)
	 }
	 }

# <description> checks
if (!($NuspecDescription)) {
    Write-Host "           ** <description> - element is empty, this element is a requirement." -Foreground Red
   } else {
     Check-Header
     Check-Footer
     if ($NuspecDescription.Length -lt 30) {Write-Warning "  ** <description> - is less than 30 characters."}
     if ($NuspecDescription.Length -gt 4000) {Write-Warning "  ** <description> - is greater than 4,000 characters."}
	 if ($NuspecDescription -match "raw.githubusercontent"){
		 if ($UpdateImageURLs){
             Write-Warning "  ** <description> - includes a GitHub direct link."
			 Write-Host "           ** <description> - URL(s) updated to use Staticly CDN." -Foreground Green
             $NuspecDescription=(Update-CDNURL "$NuspecDescription")
		 } else {
		   Write-Warning "  ** <description> - includes a GitHub direct link. Please change to a CDN such as:"
           Write-Host "           ** $CDNlist" -Foreground Cyan
		   Write-Host "           ** Consider running CNC -UpdateImageURLs to update it." -Foreground Cyan		   
          }
	   }
     if ($NuspecDescription -match "cdn.rawgit.com"){
		 if ($UpdateImageURLs){
             Write-Warning "  ** <description> - includes a RawGit CDN link."
			 Write-Host "           ** <description> - URL(s) updated to use Staticly CDN." -Foreground Green
             $NuspecDescription=(Update-CDNURL "$NuspecDescription")
		 } else {
		   Write-Warning "  ** <description> - RawGit CDN will be going offline October 2019. Please change to a CDN such as:"
           Write-Host "           ** $CDNlist" -Foreground Cyan
		   Write-Host "           ** Consider running CNC -UpdateImageURLs to update it." -Foreground Cyan
		 }
       }
	}
	
# add header template to <description> if -AddHeader is passed to script
if ($AddHeader) {
$NuspecDescription=(Add-Header)
}

# add footer template to <description> if -AddFooter is passed to script
if ($AddFooter) {
$NuspecDescription=(Add-Footer)
}
	
# <docsUrl> checks
if (!($NuspecDocsURL)) {
    Write-Warning "  ** <docsUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: docsUrl - points to the location of the wiki or docs of the software' -Foreground Cyan
   } else {
     Validate-URL "<docsUrl>" $NuspecDocsURL
	}

# <files> checks
if (!($NuspecFiles)) {
    Write-Warning "  ** <files> - element is empty. All of the following files will be packaged:"
#	Get-ChildItem -Path $path -Exclude *.nupkg | Write-Host -Foreground Cyan
    Get-ChildItem -Path $pwd -Recurse -Exclude *.nupkg,tools |% $_.file {Write-Host "           ** $_" -Foreground Cyan -ea SilentlyContinue}
	}

# <iconUrl> checks
if (!($NuspecIconURL)) {
    Write-Warning "  ** <iconUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Guideline: The iconUrl should be added if there is one. Please correct this in the nuspec, if applicable.' -Foreground Cyan
   } else {
     Validate-URL "<iconUrl>" $NuspecIconURL
	 $IconExt=($NuspecIconURL | Select-String -Pattern $AcceptableIconExts)
     if (!($IconExt)){
	     Write-Warning "  ** <iconUrl> - Your package icon is NOT a .PNG or .SVG. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: As per the packaging guidelines icons should be either a png or svg file.' -Foreground Cyan
       }
	 if ($NuspecIconURL -match "raw.githubusercontent"){
         if ($UpdateImageURLs) {
		    $NuspecIconURL=(Update-CDNURL "$NuspecIconURL")
			Write-Warning "  ** <iconUrl> - Your package icon links directly to GitHub."
			Write-Host "           ** <iconUrl> - URL updated to: `n              $NuspecIconURL" -Foreground Green
		   } else {
		     Write-Warning "  ** <iconUrl> - Your package icon links directly to GitHub. Please use a CDN such as:"
             Write-Host "           ** $CDNlist" -Foreground Cyan		   
		     Write-Host "           ** Consider running CNC -UpdateImageURLs to update it." -Foreground Cyan
		   }
		}
     if ($NuspecIconURL -match "cdn.rawgit.com"){
         if ($UpdateImageURLs) {
		    $NuspecIconURL=(Update-CDNURL "$NuspecIconURL")
			Write-Warning "  ** <iconUrl> - Your package icon links RawGit which will be going offline October 2019."
			Write-Host "           ** <iconUrl> - URL updated to: `n              $NuspecIconURL" -Foreground Green
		   } else {
		     Write-Warning "  ** <iconUrl> - RawGit CDN will be going offline October 2019. Please change to a CDN such as:"
             Write-Host "           ** $CDNlist" -Foreground Cyan
		     Write-Host "           ** Consider running CNC -UpdateImageURLs to update it." -Foreground Cyan
		   }
       }
   }

# <id> checks
if (!($NuspecID)) {
    Write-Host "           ** <id> - element is empty, this element is a requirement." -Foreground Red
	} else {
     if (($NuspecID.Length -gt 20) -and (!$NuspecID.Contains("-")) -and (!$NuspecID.Contains("."))) {
	     Write-Warning "  ** <id> - is greater than 20 characters. This will trigger a message from the verifier:"
	     Write-Host "           ** Note: If this is a new package that has never been approved, moderators will review and reject the`n              package for one that will be pushed with a new id that meets the package naming guidelines." -Foreground Cyan
	    }
	 if ($NuspecID -cmatch "[A-Z]") {Write-Warning "  ** <id> - includes UPPERcase letters." }
	 if (($NuspecID.Contains(".")) -and (!$NuspecID.Contains(".install")) -and (!$NuspecID.Contains(".portable")) -and (!$NuspecID.Contains(".extension"))) {
	      Write-Warning "  ** <id> - includes a '.'. This will trigger a message from the verifier:"
		  Write-Host "           ** Note: If this is a new package that has never been approved, moderators will review and reject the package`n              for one that will be pushed with a new id that meets the package naming guidelines."  -Foreground Cyan
		 }
	 }

# <licenseUrl> checks
if (!($NuspecLicenseURL)) {
    Write-Warning "  ** <licenseUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host "           ** Guideline: The licenseUrl should be added if there is one. Please correct this in the nuspec,`n              if applicable." -Foreground Cyan
   } else {
     Validate-URL "<licenseUrl>" $NuspecLicenseURL
	}	

# <mailingListUrl> checks
if (!($NuspecMailingListURL)) {
    Write-Warning "  ** <mailingListUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: mailingListUrl - points to the forum or email list group for the software' -Foreground Cyan
   } else {
     Validate-URL "<mailingListUrl>" $NuspecMailingListURL
	}
	
# <owners> checks
if (!($NuspecOwners)) {
    Write-Warning "  ** <owners> element is empty."
   } else {
     if ($NuspecAuthors -eq $NuspecOwners){
        Write-Warning "  ** <owners> and <authors> elements are the same. This will trigger a message from the verifier:"
        Write-Host "           ** Note: The package maintainer field (owners) matches the software author field (authors) in the nuspec.`n              The reviewer will ensure that the package maintainer is also the software author." -Foreground Cyan
		}
   }

# <packageSourceUrl> checks
if (!($NuspecPackageSourceURL)) {
    Write-Warning "  ** <packageSourceUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host "           ** Guideline: The nuspec has been enhanced to allow packageSourceUrl, pointing to the url where the package`n              source resides. This is a strong guideline because it simplifies collaboration.`n              Please add it to the nuspec." -Foreground Cyan
   } else {
     Validate-URL "<packageSourceUrl>" $NuspecPackageSourceURL
	}		

# <projectSourceUrl> checks
if (!($NuspecProjectSourceURL)) {
    Write-Warning "  ** <projectSourceUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: projectSourceUrl - points to the location of the underlying software source' -Foreground Cyan
   } else {
     Validate-URL "<projectSourceUrl>" $NuspecProjectSourceURL
	 if ($NuspecProjectURL -eq $NuspecProjectSourceURL){
         Write-Warning "  ** <projectUrl> and <projectSourceUrl> elements are the same. This will trigger a message from the verifier:"
         Write-Host "           ** Guideline: ProjectUrl and ProjectSourceUrl are typically different, but not always. Please ensure`n              that projectSourceUrl is pointing to software source code or remove the field from the nuspec." -Foreground Cyan
       }
	}
	
# <projectUrl> checks
if (!($NuspecProjectURL)) {
    Write-Warning "  ** <projectUrl> - element is empty."
   } else {
     Validate-URL "<projectUrl>" $NuspecProjectURL
	}	

# <provides> checks - Built for the future
#if (!($NuspecProvides)) {Write-Warning "  ** <provides> element is empty"}

# <releaseNotes> checks
if (!($NuspecReleaseNotes)) {
    Write-Warning "  ** <releaseNotes> element is empty. This will trigger a message from the verifier:"
	Write-Host "           ** Guideline: Release Notes (releaseNotes) are a short description of changes in each version of a package.`n              Please include releasenotes in the nuspec. NOTE: To prevent the need to continually update this field,`n              providing a URL to an external list of Release Notes is perfectly acceptable." -Foreground Cyan
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
if (!($NuspecSummary)) {
    Write-Warning "  ** <summary> - element is empty. This will trigger a message from the verifier:"
    Write-Host '           ** Guideline: Summary (summary) is a short explanation of the software. Please include summary in the nuspec.' -Foreground Cyan
	}

# <tags> checks
if (!($NuspecTags)) {
     Write-Warning "  ** <tags> - element is empty."
	} else {
	  if ($NuspecTags -match ","){
         Write-Warning "  ** <tags> - tags are separated with commas. They should only be separated with spaces."
		}
	  if ($NuspecTags -match "chocolatey"){
         Write-Warning "  ** Note: There is a tag named ""chocolatey"" which will trigger a message from the verifier:"
         Write-Host '           ** Tags (tags) should not contain 'chocolatey' as a tag. Please remove that in the nuspec.' -Foreground Cyan
		}
	  if ($NuspecTags -match "notsilent"){
         Write-Warning "  ** Note: There is a tag named ""notsilent"" which will trigger a message from the verifier:"
         Write-Host '           ** Note: notSilent tag is being used. The reviewer will ensure this is being used appropriately. ' -Foreground Cyan
		}		
    }

# <title> checks
if (!($NuspecTitle)) {Write-Warning "  ** <title> - element is empty."}

# <version> checks
if (!($NuspecVersion)) {Write-Host "           ** <version> - element is empty, this element is a requirement." -Foreground Red}

# cocolateyInstall.ps1 and chocolateyUninstall.ps1 script checks
# out of scope, but nice to have
    if (Test-Path "$pwd\tools\chocolateyinstall.ps1") {
	    $ScriptError=Test-PowerShellSyntax (Get-Item "$pwd\tools\chocolateyinstall.ps1")
		if ($ScriptError.SyntaxErrorsFound){
		     Write-Warning "  ** PowerShell syntax errors found in $pwd\tools\chocolateyinstall.ps1"
			 }
	    $PS1Encoding=(Get-FileEncoding -Path $pwd\tools\chocolateyinstall.ps1)
		if ($PS1Encoding -ne 'UTF-8 w/ BOM'){
            Write-Warning "  ** CHOCOLATEYINSTALL.PS1 is encoded using $PS1Encoding."
			Write-Host '           ** PowerShell scripts need to be saved in UTF–8 with BOM.' -Foreground Cyan
		}
    }
    $ScriptError=$False
    if (Test-Path "$pwd\tools\chocolateyUninstall.ps1") {
	    $ScriptError=Test-PowerShellSyntax (Get-Item "$pwd\tools\chocolateyUninstall.ps1")
        if ($ScriptError.SyntaxErrorsFound){
	        Write-Warning "  ** PowerShell syntax errors found in $pwd\tools\chocolateyUninstall.ps1"
		    }
		$PS1Encoding=(Get-FileEncoding -Path $pwd\tools\chocolateyuninstall.ps1)
		if ($PS1Encoding -ne 'UTF-8 w/ BOM'){
            Write-Warning "  ** CHOCOLATEYUNINSTALL.PS1 is encoded using $PS1Encoding."
			Write-Host '           ** PowerShell scripts need to be saved in UTF–8 with BOM.' -Foreground Cyan
		}
		}

# Binaries checks
Check-Binaries

# Git 'er done ------------------------------------------------------------------------------------------------

if ($global:UpdateNuspec) {
	Update-nuspec
	}

Write-Host "`nFound CNC.ps1 useful?" -Foreground White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -Foreground White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -Foreground White
return

# TDL
# parse variables placed in header/footer - priority high
# inject UTF-8 test comment -started 
# implement multiple CDN choices for iconURL (default Staticly, but -option for others)
# implement PngOptimizer (CommandLine) run on PNG files
# implement syntax and BOM checking on OTHER .ps1 files
# check for &'s in links and description to change to &amp;
# https://www.regular-expressions.info/powershell.html
# check for "Nuspec file contains templated values which should be removed."
# option of displaying useful tips and tweaks (AutoHotKey, BeCyIconGrabber, PngOptimizer, Regshot, service viewer program, Sumo, etc)
# MAYBE redo file selection by filename instead of directory and implement a -Recurse option - medium low priority
# MAYBE do full params statement and get rid of args checking - low priority
# MAYBE implement a warning and hard error count to report as well as # of changes- medium low priority
# MAYBE error check 0 byte nuspec files (causes error with Get-FileEncoding) - medium low priority
# MAYBE check http links to see if https links are available and report if so - low priority
# MAYBE download icon file and check it's dimension - very low priority
# MAYBE change install script ACL handling to use icacls
# MAYBE add ps1 $ErrorActionPreference = 'Stop' check
# MAYBE add delete old .nupkg options (all but current) -DeleteOld ? -CleanUp ?
# MAYBE check license/verifiction/readme files for UTF-8 w/o BOM (worthwhile?)
=======
﻿# CNC.ps1 Copyleft 2018-2019 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

# REF: https://docs.microsoft.com/en-us/nuget/reference/nuspec
# REF: https://github.com/chocolatey/package-validator/wiki

param (
    [string]$path=(Get-Location)
 )
 
Write-Host "CNC.ps1 v2019.01.26 - (unofficial) Chocolatey .nuspec Checker ""CNC - Run it through the Bill.""" -Foreground White
Write-Host "Copyleft 2018-2019 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use" -Foreground White
Write-Host

$AcceptableIconExts=@("png","svg")
$BinaryExtensions=@("*.exe","*.msi","*.zip","*.rar","*.7z","*.gz","*.tar","*.sfx","*.iso","*.img","*.msu","*.msp","*.appx","*.appxbundle") # miss any?
$CDNlist     = "https://www.staticaly.com, https://raw.githack.com, https://gitcdn.link, or https://www.jsdelivr.com"
$CNCHeader   = "$ENV:ChocolateyInstall\bin\CNCHeader.txt"
$CNCFooter   = "$ENV:ChocolateyInstall\bin\CNCFooter.txt"
$global:UpdateNuspec=$False
$RunFrom=$pwd

if (($args -eq "-help") -or ($args -eq "-?") -or ($args -eq "/?")) {
    Write-Host "OPTIONS AND SWITCHES:" -Foreground Magenta
	Write-Host "-help, -?, or /?"
	Write-Host "   Displays this information."
	Write-Host "-AddFooter"
    Write-Host "   Adds and saves a footer from $CNCFooter to your <description>."	
	Write-Host "-AddHeader"
    Write-Host "   Adds and saves a header from $CNCHeader to your <description>."
	Write-Host "-EditFooter"
    Write-Host "   Edit $CNCFooter with Notepad++ or Notepad."
	Write-Host "-EditHeader"
    Write-Host "   Edit $CNCHeader with Notepad++ or Notepad."
	Write-Host "-OpenURLs"
    Write-Host "   Opens all URLs in your browser for inspection when finished."
	Write-Host "-OpenValidatorInfo"
    Write-Host "   Opens the Chocolatey package-validator info page on GitHub in your default browser."	
	Write-Host "-ShowFooter"
    Write-Host "   Displays $CNCFooter."	
	Write-Host "-ShowHeader"
    Write-Host "   Displays $CNCHeader."
	Write-Host "-Update"
    Write-Host "   Will re-write out your nuspec file; e.g. change to UTF-8 w/o BOM."
	Write-Host "-UpdateAll"
    Write-Host "   Same as -UpdateImageURLs with -UpdateXMLDeclaration."
	Write-Host "-UpdateImageURLs"
    Write-Host "   Updates image URLs with Staticaly CDN URLs."
	Write-Host "-UpdateXMLDeclaration"
    Write-Host "   Updates the XML declaration."
	Write-Host "-WhatIf"
    Write-Host "   Don't save changes."
	Write-Host "To check all your packages' .nuspec files: Change to the root directory of your packages and run (via PowerShell):" -Foreground Magenta
	Write-Host 'Get-ChildItem | ?{if ($_.PSIsContainer){cls;cd $_.Name;cnc;cd ..;pause}}' -Foreground Magenta
	return
}

if (Test-Path $ENV:ChocolateyInstall\bin\notepad++.exe){
     $Editor="notepad++.exe"
    } else {
      $Editor="notepad.exe"
    }

if ($args -eq "-EditFooter") {
    Write-Host "  ** Editing contents of $CNCFooter." -Foreground Magenta
	&$Editor $CNCFooter
	return
}

if ($args -eq "-EditHeader") {
    Write-Host "  ** Editing contents of $CNCHeader." -Foreground Magenta
	&$Editor $CNCHeader
	return
}

if ($args -eq "-ShowFooter") {
	Write-Host "  ** Displaying contents of $CNCFooter." -Foreground Magenta
    Write-Host	
    Get-Content $CNCFooter
	return
}

if ($args -eq "-ShowHeader") {
    Write-Host "  ** Displaying contents of $CNCHeader." -Foreground Magenta
    Write-Host	
    Get-Content $CNCHeader
	return
}

if ($args -eq "-OpenValidatorInfo") {
    Write-Host "  ** Opening https://github.com/chocolatey/package-validator/wiki." -Foreground Magenta
    Write-Host	
    &start https://github.com/chocolatey/package-validator/wiki
	return
}

if ($args -eq "-AddHeader") {
     $AddHeader=$True
   } else {
     $AddHeader=$False
}

if ($args -eq "-AddFooter") {
     $AddFooter=$True
   } else {
     $AddFooter=$False
}

if ($args -eq "-UpdateImageURLs") {
     $UpdateImageURLs=$True
   } else {
     $UpdateImageURLs=$False
}

if ($args -eq "-UpdateXMLDeclaration") {
     $UpdateXMLDeclaration=$True
   } else {
     $UpdateXMLDeclaration=$False
}

if ($args -eq "-Update") {
	 $global:UpdateNuspec=$True
}

if ($args -eq "-UpdateAll") {
     $UpdateAll=$True
	 $UpdateImageURLs=$True
	 $UpdateXMLDeclaration=$True
	 $global:UpdateNuspec=$True
   } else {
     $UpdateAll=$False
}

if ($args -eq "-WhatIf") {
     $WhatIf=$True
   } else {
     $WhatIf=$False
}

if (!(Test-Path $path)){
    Write-Host "           ** $path is an invalid path." -Foreground Red
	return
#    $path=Get-Location
#	Write-Host "  ** Changing path to $path."
   }

# Finds nuspec file for processing. Defaults to current working directory.
# You can specify a directory path, but do NOT specify the file itself, just the directory.
if (!$path) {$LocalnuspecFile = Get-Item ./*.nuspec}
if ($path) {$LocalnuspecFile = Get-Item $path\*.nuspec}
if (!($LocalnuspecFile)) {
    $CurrentDir=$path
    Write-Host "           ** No .nuspec file found in $CurrentDir" -Foreground Red
	return
   }

# Borrowed from
# https://blogs.technet.microsoft.com/samdrey/2014/03/26/determine-the-file-encoding-of-a-file-csv-file-with-french-accents-or-other-exotic-characters-that-youre-trying-to-import-in-powershell/
# UTF8 w/o BOM sometimes reports as ASCII. UTF8 w/BOM is not desired per "You must save your files with UTF–8 character encoding without BOM."
function Get-FileEncoding
{
    [CmdletBinding()] Param (
     [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)] [string]$Path
    )

    [byte[]]$byte = get-content -Encoding byte -ReadCount 4 -TotalCount 4 -Path $Path

    if ($byte[0] -eq 0xef -and $byte[1] -eq 0xbb -and $byte[2] -eq 0xbf)
    { Write-Output 'UTF-8 with BOM' } 
    elseif ($byte[0] -eq 0xfe -and $byte[1] -eq 0xff)
    { Write-Output 'Unicode' }
    elseif ($byte[0] -eq 0 -and $byte[1] -eq 0 -and $byte[2] -eq 0xfe -and $byte[3] -eq 0xff)
    { Write-Output 'UTF-32' }
    elseif ($byte[0] -eq 0x2b -and $byte[1] -eq 0x2f -and $byte[2] -eq 0x76)
    { Write-Output 'UTF-7'}
    else
    { Write-Output 'ASCII or UTF-8' } 
}

# Borrowed from
# https://web.archive.org/web/20160430132409/http://powershell.org:80/wp/forums/topic/how-to-check-syntax-of-scripts-automatically/
function Test-PowerShellSyntax
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string[]]
        $Path
    )

    process
    {
        foreach ($scriptPath in $Path) {
            $contents = Get-Content -Path $scriptPath

            if ($null -eq $contents)
            {
                continue
            }

            $errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)

            New-Object psobject -Property @{
                Path = $scriptPath
                SyntaxErrorsFound = ($errors.Count -gt 0)
            }
        }
    }
}

# Validate that URL elements are actually URLs and verify the URLs are good
# Thanks https://stackoverflow.com/questions/23760070/the-remote-server-returned-an-error-401-unauthorized
function Validate-URL([string]$element,[string]$url){
if (($url -match "http://") -or ($url -match "https://")){
     $HTTP_Response = $null
     $HTTP_Request = [System.Net.WebRequest]::Create($url)
     try{
         $HTTP_Response = $HTTP_Request.GetResponse()
         $HTTP_Status = [int]$HTTP_Response.StatusCode
         if ($HTTP_Status -eq 200) { 
            # do nothing, it's good!
         } else {
           Write-Host ("  ** $element - $url site might be OK, status code:" + $HTTP_Status)
		   Write-Host "           ** Consider using CNC's -OpenURLs option to open and view all URLs in the .nuspec." -Foreground Cyan
         }
         $HTTP_Response.Close()
        } catch {
          $HTTP_Status = [regex]::matches($_.exception.message, "(?<=\()[\d]{3}").Value
          Write-Warning ("  ** $element - ""$url"" is probably bad, status code: " + $HTTP_Status)
          Write-Host "           ** Consider using CNC's -OpenURLs option to open and view all URLs in the .nuspec." -Foreground Cyan
        }
   }
}

# Check for license files when binaries are included
function Check-LicenseFile{
$LicenseFile=(Get-ChildItem -Path $path -Include *LICENSE* -Recurse)
if ($LicenseFile){
	 Write-Host '           ** Binary files - '  $LicenseFile.Name ' file(s) found.' -Foreground Green
	} else {
	 Write-Warning "  ** Binary files - LICENSE.txt file NOT found."
   }
}

# Check for verification file when binaries are included
function Check-VerificationFile{
$VerificationFile=(Get-ChildItem -Path $path -Include *VERIFICATION* -Recurse)
if ($VerificationFile){
     Write-Host '           ** Binary files - '  $VerificationFile.Name ' file(s) found.' -Foreground Green
	} else {
	 Write-Warning "  ** Binary files - VERIFICATION.txt file NOT found."
   }
}

# check for binaries
function Check-Binaries{
$IncludedBinaries=(Get-ChildItem -Path $path -Include $BinaryExtensions -Recurse)
if ($IncludedBinaries){
    Write-Warning "  ** Binary files found in package. This will trigger a message from the verifier:"
    Write-Host "           ** Note: Binary files (.exe, .msi, .zip) have been included. The reviewer will ensure the maintainers have`n              distribution rights." -Foreground Cyan
	Check-LicenseFile
	Check-VerificationFile
   }
}

# add header template to <description>
function Add-Header{
if (Test-Path $CNCHeader){
    $Header=[IO.File]::ReadAllText($CNCHeader)
    $NuspecDescription="`n" + $Header + $NuspecDescription
    Write-Host "           ** <description> - added header template." -Foreground Green
	$global:UpdateNuspec=$True
	return $NuspecDescription
   } else {
	Write-Warning "           ** $CNCHeader not found."
   }
}

# add footer template to <description>
function Add-Footer{
if (Test-Path $CNCFooter){
    $Footer=[IO.File]::ReadAllText($CNCFooter)
    $NuspecDescription=$NuspecDescription + "`n" + $Footer
    Write-Host "           ** <description> - added footer template." -Foreground Green
    $global:UpdateNuspec=$True
	return $NuspecDescription
   } else {
	Write-Warning "           ** $CNCFooter NOT found."
   }
}

# check if header template is already in the description
function Check-Header{
$NuspecDescription=$NuspecDescription.Trim()
if ($NuspecDescription.StartsWith("***") -or $NuspecDescription.StartsWith("---") -or $NuspecDescription.StartsWith("___")){ 
    Write-Host "           ** <description> - header template found." -Foreground Green
   }
}

# check if footer template is already in the description
function Check-Footer{
$NuspecDescription=$NuspecDescription.Trim()
if ($NuspecDescription.EndsWith("***") -or $NuspecDescription.EndsWith("---") -or $NuspecDescription.EndsWith("___")){
    Write-Host "           ** <description> - footer template found." -Foreground Green
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
$global:UpdateNuspec=$True
return $StaticalyURL
}

# Update the nuspec XML declaration with encoding info
function Update-XMLDeclaration{
Write-Host "           ** XML declaration changed to version=""1.0"" encoding=""utf-8""" -Foreground Green
$nuspecFile.xml="version=""1.0"" encoding=""utf-8"""
$global:UpdateNuspec=$True
}

# Update the nuspec with any changes and save as UTF-8 w/o BOM
# Thanks https://stackoverflow.com/questions/8160613/powershell-saving-xml-and-preserving-format
Function Update-nuspec{
if ($global:UpdateNuspec){
   if ($WhatIf){
        Write-Host "CNC did NOT update $LocalnuspecFile, -WhatIf parameter was used." -Foreground Magenta
		return
   }
   $UpdatednuspecFile = [xml]([System.IO.File]::ReadAllText($LocalnuspecFile))
   $UpdatednuspecFile.PreserveWhitespace = $true
   $settings = New-Object System.Xml.XmlWriterSettings
   $settings.Indent = $true
   $settings.NewLineChars ="`r`n"
   $settings.Encoding = New-Object System.Text.UTF8Encoding($false)   

   # changes
   if ($nuspecFile.xml) {$UpdatednuspecFile.xml = $nuspecFile.xml}
   if ($NuspecDescription){$UpdatednuspecFile.package.metadata.description=[string]$NuspecDescription}
   if ($NuspecIconURL){$UpdatednuspecFile.package.metadata.iconurl=$NuspecIconURL}
   
   $xfile = [System.Xml.XmlWriter]::Create($LocalnuspecFile, $settings)
   try{
     $UpdatednuspecFile.Save($xfile)
    } finally {
     $xfile.Dispose()
    }
   Write-Host "CNC updated $LocalnuspecFile." -Foreground Magenta
  }
}

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

$NuspecDisplayName=$LocalnuspecFile.Name
$NuspecDisplayName=$NuspecDisplayName.ToUpper()

# Start outputting check results
Write-Host "CNC Summary of $NuspecDisplayName :" -Foreground Magenta

# Open all .nuspec URLs for viewing if -OpenURLs is passed
if ($args -eq "-OpenURLs") {
    Write-Host "           ** Opening all .nuspec URLs in your default browser for viewing." -Foreground Magenta
	Open-URLs
	}

# check for UTF8 encoding
$NuspecEncoding=(Get-FileEncoding -Path $LocalnuspecFile)
if ($NuspecEncoding -ne 'ASCII or UTF-8'){
    Write-Warning "  ** $NuspecDisplayName is encoded using $NuspecEncoding."
	if ($global:UpdateNuspec) {
	     Write-Host "           ** $NuspecDisplayName will be converted to UTF-8 w/o BOM and saved." -Foreground Green
		 } else {
		   Write-Host "           ** Consider running CNC -Update to re-write`n              $LocalnuspecFile to UTF-8 w/o BOM." -Foreground Cyan
	}
}

# check XML declaration
if ($nuspecFile.xml -eq "version=""1.0"""){
    Write-Warning "  ** XML declaration is version=""1.0"""
	if ($UpdateXMLDeclaration){
	    Update-XMLDeclaration
	} else {
      Write-Host "           ** Consider running CNC -UpdateXMLDeclaration to add a UTF-8 encoding statement." -Foreground Cyan
	}
}

# check XML comment
if (!$nuspecFile.'#comment'){
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
    Write-Warning "  ** The recommended UTF-8 encoding check comment was not found."
    Write-Host "           ** Consider adding a UTF-8 encoding check comment such as:" -Foreground Cyan
# Funny how this line requires UTF-8 w/BOM encoding to display correctly
	Write-Host "              <!-- Do not remove this test for UTF-8: if `“Ω`” doesn’t appear as greek uppercase omega letter enclosed in
              quotation marks, you should use an editor that supports UTF-8, not this one. -->" -Foreground Cyan
}

# <authors> checks
if (!($NuspecAuthors)) {
    Write-Host "           ** <authors> element is empty, this element is a requirement." -Foreground Red
   } else {
     if ($NuspecAuthors -match "@"){
	     Write-Warning "  ** <authors> - contains an e-mail address. This will trigger a message from the verifier:"
	     Write-Host '           ** Requirements: Email address should not be used in the Author and Copyright fields of the nuspec file. ' -Foreground Cyan
	 }
   }

# <bugTrackerUrl> checks
if (!($NuspecBugTrackerURL)) {
     Write-Warning "  ** <bugTrackerUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: bugTrackerUrl - points to the location where issues and tickets can be accessed' -Foreground Cyan
   } else {
     Validate-URL "<bugTrackerUrl>" $NuspecBugTrackerURL
	}

# <conflicts> checks - Built for the future
#if (!($NuspecConflicts)) {Write-Warning "  ** <conflicts> element is empty."}

# <copyright> checks
if (!($NuspecCopyright)) {
    Write-Warning "  ** <copyright> - element is empty."
	} else {
	  if ($NuspecCopyright.Length -lt 5) {
	      Write-Warning "  ** <copyright> - Please update the copyright field so that it is using at least 4 characters."
		  }
	  if ($NuspecAuthors -match "@"){
	      Write-Warning "  ** <copyright> - contains an e-mail address. This will trigger a message from the verifier:"
	      Write-Host '           ** Requirements: Email address should not be used in the Author and Copyright fields of the nuspec file. ' -Foreground Cyan
	 }
	}

# <dependencies> checks
if (!($NuspecDependencies)) {
    Write-Warning "  ** <dependencies> - element is empty."
   } else {
     if ((!$NuspecDependencies) -and ($NuspecTitle -match "deprecated")){Write-Warning "  ** <dependencies> - Deprecated packages must have a dependency."}
	 if ($NuspecDependencies.dependency.id -eq 'chocolatey'){
	     Write-Warning "  ** <dependencies> - ""chocolatey"" is a dependency. This will trigger a message from the verifier:"
	     Write-Host "           ** Note: The package takes a dependency on Chocolatey. The reviewer will ensure the package uses a specific`n              Chocolatey feature that requires a minimum version." -Foreground Cyan
		 }
	 $DependencyName=$NuspecDependencies.dependency.id
	 if ($NuspecDependencies.dependency.id.count -eq 1){
    	 if ($NuspecDependencies.dependency.version -eq $null){
	          Write-Warning "  ** <dependencies> - $DependencyName has no version. This will trigger a message from the verifier:"
      	      Write-Host "           ** Guideline: Package contains dependencies with no specified version. You should at least specify`n              a minimum version of a dependency." -Foreground Cyan
	         }
	 } else {
	   $DependencyNumber=0
	 do{
	    $DependencyName=$NuspecDependencies.dependency.id[$DependencyNumber]
 	    if ($NuspecDependencies.dependency[$DependencyNumber].version -eq $null){
				Write-Warning "  ** <dependencies> - ""$DependencyName"" has no version. This will trigger a message from the verifier:"
			    Write-Host "           ** Guideline: Package contains dependencies with no specified version. You should at least specify`n              a minimum version of a dependency." -Foreground Cyan
			}
	   $DependencyNumber++
       } while ($DependencyNumber -lt $NuspecDependencies.dependency.id.count)
	 }
	 }

# <description> checks
if (!($NuspecDescription)) {
    Write-Host "           ** <description> - element is empty, this element is a requirement." -Foreground Red
   } else {
     Check-Header
     Check-Footer
     if ($NuspecDescription.Length -lt 30) {Write-Warning "  ** <description> - is less than 30 characters."}
     if ($NuspecDescription.Length -gt 4000) {Write-Warning "  ** <description> - is greater than 4,000 characters."}
	 if ($NuspecDescription -match "raw.githubusercontent"){
         Write-Warning "  ** <description> - has a GitHub direct link. Please change to a CDN such as:"
         Write-Host "           ** $CDNlist" -Foreground Cyan
#         Update-CDNURL - (need to parse and pass URL)
        }
     if ($NuspecDescription -match "cdn.rawgit.com"){
         Write-Warning "  ** <description> - RawGit CDN will be going offline October 2019. Please change to a CDN such as:"
         Write-Host "           ** $CDNlist" -Foreground Cyan
#         Update-CDNURL - (need to parse and pass URL)
       }
	}
	
# add header template to <description> if -AddHeader is passed to script
if ($AddHeader) {
$NuspecDescription=(Add-Header)
}

# add footer template to <description> if -AddFooter is passed to script
if ($AddFooter) {
$NuspecDescription=(Add-Footer)
}
	
# <docsUrl> checks
if (!($NuspecDocsURL)) {
    Write-Warning "  ** <docsUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: docsUrl - points to the location of the wiki or docs of the software' -Foreground Cyan
   } else {
     Validate-URL "<docsUrl>" $NuspecDocsURL
	}

# <files> checks
if (!($NuspecFiles)) {
    Write-Warning "  ** <files> - element is empty. All of the following files will be packaged:"
#	Get-ChildItem -Path $path -Exclude *.nupkg | Write-Host -Foreground Cyan
    Get-ChildItem -LiteralPath $pwd -Recurse -Exclude *.nupkg |% $_.file {Write-Host "           ** $_" -Foreground Cyan -ea SilentlyContinue}
	}

# <iconUrl> checks
if (!($NuspecIconURL)) {
    Write-Warning "  ** <iconUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Guideline: The iconUrl should be added if there is one. Please correct this in the nuspec, if applicable.' -Foreground Cyan
   } else {
     Validate-URL "<iconUrl>" $NuspecIconURL
	 $IconExt=($NuspecIconURL | Select-String -Pattern $AcceptableIconExts)
     if (!($IconExt)){
	     Write-Warning "  ** <iconUrl> - Your package icon is NOT a .PNG or .SVG. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: As per the packaging guidelines icons should be either a png or svg file.' -Foreground Cyan
       }
	 if ($NuspecIconURL -match "raw.githubusercontent"){
         if ($UpdateImageURLs) {
		    $NuspecIconURL=(Update-CDNURL "$NuspecIconURL")
			Write-Warning "  ** <iconUrl> - Your package icon links directly to GitHub."
			Write-Host "           ** <iconUrl> - URL updated to: `n              $NuspecIconURL" -Foreground Green
		   } else {
		     Write-Warning "  ** <iconUrl> - Your package icon links directly to GitHub. Please use a CDN such as:"
             Write-Host "           ** $CDNlist" -Foreground Cyan		   
		     Write-Host "           ** Consider running CNC -UpdateImageURLs to update it." -Foreground Cyan
		   }
		}
     if ($NuspecIconURL -match "cdn.rawgit.com"){
         if ($UpdateImageURLs) {
		    $NuspecIconURL=(Update-CDNURL "$NuspecIconURL")
			Write-Warning "  ** <iconUrl> - Your package icon links RawGit which will be going offline October 2019."
			Write-Host "           ** <iconUrl> - URL updated to: `n              $NuspecIconURL" -Foreground Green
		   } else {
		     Write-Warning "  ** <iconUrl> - RawGit CDN will be going offline October 2019. Please change to a CDN such as:"
             Write-Host "           ** $CDNlist" -Foreground Cyan
		     Write-Host "           ** Consider running CNC -UpdateImageURLs to update it." -Foreground Cyan
		   }
       }
   }

# <id> checks
if (!($NuspecID)) {
    Write-Host "           ** <id> - element is empty, this element is a requirement." -Foreground Red
	} else {
     if (($NuspecID.Length -gt 20) -and (!$NuspecID.Contains("-")) -and (!$NuspecID.Contains("."))) {
	     Write-Warning "  ** <id> - is greater than 20 characters. This will trigger a message from the verifier:"
	     Write-Host "           ** Note: If this is a new package that has never been approved, moderators will review and reject the`n              package for one that will be pushed with a new id that meets the package naming guidelines." -Foreground Cyan
	    }
	 if ($NuspecID -cmatch "[A-Z]") {Write-Warning "  ** <id> - includes UPPERcase letters." }
	 if (($NuspecID.Contains(".")) -and (!$NuspecID.Contains(".install")) -and (!$NuspecID.Contains(".portable")) -and (!$NuspecID.Contains(".extension"))) {
	      Write-Warning "  ** <id> - includes a '.'. This will trigger a message from the verifier:"
		  Write-Host "           ** Note: If this is a new package that has never been approved, moderators will review and reject the package`n              for one that will be pushed with a new id that meets the package naming guidelines."  -Foreground Cyan
		 }
	 }

# <licenseUrl> checks
if (!($NuspecLicenseURL)) {
    Write-Warning "  ** <licenseUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host "           ** Guideline: The licenseUrl should be added if there is one. Please correct this in the nuspec,`n              if applicable." -Foreground Cyan
   } else {
     Validate-URL "<licenseUrl>" $NuspecLicenseURL
	}	

# <mailingListUrl> checks
if (!($NuspecMailingListURL)) {
    Write-Warning "  ** <mailingListUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: mailingListUrl - points to the forum or email list group for the software' -Foreground Cyan
   } else {
     Validate-URL "<mailingListUrl>" $NuspecMailingListURL
	}
	
# <owners> checks
if (!($NuspecOwners)) {
    Write-Warning "  ** <owners> element is empty."
   } else {
     if ($NuspecAuthors -eq $NuspecOwners){
        Write-Warning "  ** <owners> and <authors> elements are the same. This will trigger a message from the verifier:"
        Write-Host "           ** Note: The package maintainer field (owners) matches the software author field (authors) in the nuspec.`n              The reviewer will ensure that the package maintainer is also the software author." -Foreground Cyan
		}
   }

# <packageSourceUrl> checks
if (!($NuspecPackageSourceURL)) {
    Write-Warning "  ** <packageSourceUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host "           ** Guideline: The nuspec has been enhanced to allow packageSourceUrl, pointing to the url where the package`n              source resides. This is a strong guideline because it simplifies collaboration.`n              Please add it to the nuspec." -Foreground Cyan
   } else {
     Validate-URL "<packageSourceUrl>" $NuspecPackageSourceURL
	}		

# <projectSourceUrl> checks
if (!($NuspecProjectSourceURL)) {
    Write-Warning "  ** <projectSourceUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: projectSourceUrl - points to the location of the underlying software source' -Foreground Cyan
   } else {
     Validate-URL "<projectSourceUrl>" $NuspecProjectSourceURL
	 if ($NuspecProjectURL -eq $NuspecProjectSourceURL){
         Write-Warning "  ** <projectUrl> and <projectSourceUrl> elements are the same. This will trigger a message from the verifier:"
         Write-Host "           ** Guideline: ProjectUrl and ProjectSourceUrl are typically different, but not always. Please ensure`n              that projectSourceUrl is pointing to software source code or remove the field from the nuspec." -Foreground Cyan
       }
	}
	
# <projectUrl> checks
if (!($NuspecProjectURL)) {
    Write-Warning "  ** <projectUrl> - element is empty."
   } else {
     Validate-URL "<projectUrl>" $NuspecProjectURL
	}	

# <provides> checks - Built for the future
#if (!($NuspecProvides)) {Write-Warning "  ** <provides> element is empty"}

# <releaseNotes> checks
if (!($NuspecReleaseNotes)) {
    Write-Warning "  ** <releaseNotes> element is empty. This will trigger a message from the verifier:"
	Write-Host "           ** Guideline: Release Notes (releaseNotes) are a short description of changes in each version of a package.`n              Please include releasenotes in the nuspec. NOTE: To prevent the need to continually update this field,`n              providing a URL to an external list of Release Notes is perfectly acceptable." -Foreground Cyan
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
if (!($NuspecSummary)) {
    Write-Warning "  ** <summary> - element is empty. This will trigger a message from the verifier:"
    Write-Host '           ** Guideline: Summary (summary) is a short explanation of the software. Please include summary in the nuspec.' -Foreground Cyan
	}

# <tags> checks
if (!($NuspecTags)) {
     Write-Warning "  ** <tags> - element is empty."
	} else {
	  if ($NuspecTags -match ","){
         Write-Warning "  ** <tags> - tags are separated with commas. They should only be separated with spaces."
		}
	  if ($NuspecTags -match "chocolatey"){
         Write-Warning "  ** Note: There is a tag named ""chocolatey"" which will trigger a message from the verifier:"
         Write-Host '           ** Tags (tags) should not contain 'chocolatey' as a tag. Please remove that in the nuspec.' -Foreground Cyan
		}
	  if ($NuspecTags -match "notsilent"){
         Write-Warning "  ** Note: There is a tag named ""notsilent"" which will trigger a message from the verifier:"
         Write-Host '           ** Note: notSilent tag is being used. The reviewer will ensure this is being used appropriately. ' -Foreground Cyan
		}		
    }

# <title> checks
if (!($NuspecTitle)) {Write-Warning "  ** <title> - element is empty."}

# <version> checks
if (!($NuspecVersion)) {Write-Host "           ** <version> - element is empty, this element is a requirement." -Foreground Red}

# cocolateyInstall.ps1 and chocolateyUninstall.ps1 script checks
# out of scope, but nice to have
    if (Test-Path "$pwd\tools\chocolateyinstall.ps1") {$ScriptError=Test-PowerShellSyntax (Get-Item "$pwd\tools\chocolateyinstall.ps1")}
    if ($ScriptError.SyntaxErrorsFound){Write-Warning "  ** PowerShell syntax errors found in $pwd\tools\chocolateyinstall.ps1"}
    $ScriptError=$False
    if (Test-Path "$pwd\tools\chocolateyUninstall.ps1") {$ScriptError=Test-PowerShellSyntax (Get-Item "$pwd\tools\chocolateyUninstall.ps1")}
    if ($ScriptError.SyntaxErrorsFound){Write-Warning "  ** PowerShell syntax errors found in $pwd\tools\chocolateyUninstall.ps1"}

# Binaries checks
Check-Binaries

if ($global:UpdateNuspec) {
	Update-nuspec
	}

Write-Host "`nFound CNC.ps1 useful?" -Foreground White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -Foreground White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -Foreground White
return

# TDL
# BUG: handle multiple nuspecs in same directory (i.e. copy of)
# inject UTF-8 test comment
# implement multiple CDN choices for iconURL
# "Nuspec file contains templated values which should be removed."
# option of displaying useful tips and tweaks (AutoHotKey, BeCyIconGrabber, PngOptimizer, Regshot, service viewer program, Sumo, etc)
# check http links to see if https links are available and report if so - low priority
# MAYBE download icon file and check it's dimension - very low priority
# MAYBE implement a warning and hard error count to report
# MAYBE error check 0 byte nuspec files (causes error with Get-FileEncoding)

>>>>>>> 569b2d7294411478d2ee52bfb07a69a9f3a90929
# What else?