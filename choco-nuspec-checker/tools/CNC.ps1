# CNC.ps1 Copyleft 2018-2019 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

# REF: https://docs.microsoft.com/en-us/nuget/reference/nuspec
# REF: https://github.com/chocolatey/package-validator/wiki

param (
    [string]$path=(Get-Location).path
 )

Write-Host "CNC.ps1 v2019.02.18 - (unofficial) Chocolatey .nuspec Checker ""CNC - Run it through the Bill.""" -Foreground White
Write-Host "Copyleft 2018-2019 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

# parameters and variables -------------------------------------------------------------------------------------

$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$AcceptableIconExts=@("png","svg")
$BinaryExtensions=@("*.exe","*.msi","*.zip","*.rar","*.7z","*.gz","*.tar","*.sfx","*.iso","*.img","*.msu","*.msp","*.appx","*.appxbundle") # What others?
$CDNlist      = "https://www.staticaly.com, https://raw.githack.com, https://gitcdn.link, or https://www.jsdelivr.com"
$CNCHeader    = "$ENV:ChocolateyInstall\bin\CNCHeader.txt"
$CNCFooter    = "$ENV:ChocolateyInstall\bin\CNCFooter.txt"
$PNGOptimizer = (Test-Path $ENV:ChocolateyInstall\bin\PngOptimizerCL.exe)
$NewCDN       = "Staticly"
$StaticlyCDN  = $True
$GLOBAL:Required=0
$GLOBAL:Guidelines=0
$GLOBAL:Suggestions=0
$GLOBAL:Notes=0
$GLOBAL:Fixes=0
$GLOBAL:FYIs=0
$GLOBAL:UpdateNuspec=$False
$GLOBAL:TemplateError=0
$XMLComment = "Do not remove this test for UTF-8: if `“Ω`” doesn`’t appear as greek uppercase omega letter enclosed in quotation marks, you should use an editor that supports UTF-8, not this one."

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
	Write-Host "-MakeBackups"
    Write-Host "   Make filename.ext.CNC.BAK of all modified files."
	Write-Host "-OpenURLs"
    Write-Host "   Opens all URLs in your browser for inspection when finished."
	Write-Host "-OpenValidatorInfo"
    Write-Host "   Opens the Chocolatey package-validator info page on GitHub in your default browser."	
	Write-Host "-ShowFooter"
    Write-Host "   Displays $CNCFooter."	
	Write-Host "-ShowHeader"
    Write-Host "   Displays $CNCHeader."
	Write-Host "-OptimizePNGs"
    Write-Host "   Runs PNGOptimizerCL on your PNG files."
	Write-Host "-Update"
    Write-Host "   Will re-write out your nuspec file; e.g. change to UTF-8 w/o BOM."
	Write-Host "-UpdateAll"
    Write-Host "   Rights all wrongs."
	Write-Host "-UpdateImageURLs"
    Write-Host "   Updates image URLs with Staticaly CDN URLs (default)."
	Write-Host "-UpdateScripts"
    Write-Host "   Will re-write out your PowerShell scripts, e.g. change to UTF-8 w/BOM, and add ErrorActionPreference=Stop."
	Write-Host "-UpdateXMLComment"
    Write-Host "   Updates the XML comment for UTF-8 checking."
	Write-Host "-UpdateXMLDeclaration"
    Write-Host "   Updates the XML declaration."
	Write-Host "-UseGitHack"
    Write-Host "   Use GitHack for image URLs replacement, for use with -UpdateImageURLs or -UpdateAll."
	Write-Host "-UseGitCDN"
    Write-Host "   Use GitCDN for image URLs replacement, for use with -UpdateImageURLs or -UpdateAll."
    Write-Host "-UsejsDelivr"
    Write-Host "   Use jsDeliver for image URLs replacement, for use with -UpdateImageURLs or -UpdateAll."
	Write-Host "-WhatIf"
    Write-Host "   Test run, don't save changes."
	Write-Host "To check all your packages' nuspec files: Change to the root directory of your packages and run (via PowerShell):" -Foreground Magenta
	Write-Host '   Get-ChildItem | ?{if ($_.PSIsContainer){cls;cnc $_.Name;pause}}' -Foreground Magenta
	Write-Host "...but will give errors on PowerShell script checks." -Foreground Magenta
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

if ($args -eq "-MakeBackups") {
     $MakeBackups=$True
   } else {
     $MakeBackups=$False
}

if ($args -eq "-Debug") {
     $Debug=$True
   } else {
     $Debug=$False
}

if ($args -eq "-OpenURLs") {
     $OpenURLs=$True
   } else {
     $OpenURLs=$False
}

if ($args -eq "-OptimizePNGs") {
     $OptimizePNGs=$True
   } else {
     $OptimizePNGs=$False
}

if ($args -eq "-UpdateImageURLs") {
     $UpdateImageURLs=$True
   } else {
     $UpdateImageURLs=$False
}

if ($args -eq "-UpdateScripts") {
     $UpdateScripts=$True
   } else {
     $UpdateScripts=$False
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
	 $GLOBAL:UpdateNuspec=$True
}

if ($args -eq "-UpdateAll") {
     $UpdateAll=$True
	 $UpdateImageURLs=$True
	 $OptimizePNGs=$True
	 $UpdateScripts=$True
	 $UpdateXMLComment=$True
	 $UpdateXMLDeclaration=$True
	 $GLOBAL:AddPS1EAP=$True
	 $GLOBAL:UpdateNuspec=$True
   } else {
     $UpdateAll=$False
}

if ($args -eq "-UseGitHack") {
     $GitHackCDN=$True
	 $StaticlyCDN=$False
	 $NewCDN="GitHack"
   } else {
     $GitHackCDN=$False
}

if ($args -eq "-UsegitCDN") {
     $GitCDN=$True
	 $StaticlyCDN=$False
	 $NewCDN="GitCDN"
   } else {
     $GitCDN=$False
}

if ($args -eq "-UsejsDelivr") {
     $jsDelivrCDN=$True
	 $StaticlyCDN=$False
	 $NewCDN="jsDelivr"
   } else {
     $jsDelivrCDN=$False
}

if ($args -eq "-WhatIf") {
     $WhatIf=$True
   } else {
     $WhatIf=$False
}

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
if ($LocalnuspecFile.length -lt 168){ # approximate value of a minimal blank nuspec template
    Write-Host "           ** $LocalnuspecFile file appears to be blank or corrupt." -Foreground Red
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
$NuspecXMLComment = $nuspecFile.'#comment'

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

# Get iconUrl dimensions
# Supports BMP, GIF, EXIF, JPG, PNG and TIFF
# Will error on URLs such as
# https://lh3.googleusercontent.com/n6kpA-xZE_0iEy9A8WkJpGT45XB6MEq09t9UdBoIrCfwIoBm3CA9gqI13AqbBN6yx7GwVDjx=s26-h26-e365-rw
function Get-ImageDimensions{
Write-Host "(Downloading icon)" -NoNewLine -Foreground Magenta
(New-Object System.Net.WebClient).DownloadFile($NuspecIconURL, "$pwd\iconURL.image")
Write-Host "`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b                  `b`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b" -NoNewLine
if (Test-Path "$pwd\iconURL.image"){
    add-type -AssemblyName System.Drawing
    $image = New-Object System.Drawing.Bitmap "$pwd\iconURL.image"
    $height=$image.height
    $width=$image.width
    $image.dispose()
    if (($height -lt 128) -and ($width -lt 128)){
	if (!$height){$height="?"}
	if (!$width){$width="?"}
        Write-Warning "  ** <iconUrl> - icon dimensions are h$height x w$width."
	    Write-Host "           ** Suggestion: Use package icons with at least 128 pixels in width or height if available." -Foreground Cyan
		$GLOBAL:Suggestions++
       }
    Remove-Item "$pwd\iconURL.image" -Force
   }
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
     Write-Host "(Validating URL)" -NoNewLine -Foreground Magenta
     $HTTP_Response = $null
     $HTTP_Request = [System.Net.WebRequest]::Create($url)
     try{
         $HTTP_Response = $HTTP_Request.GetResponse()
		 Write-Host "`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b                `b`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b" -NoNewLine
         $HTTP_Status = [int]$HTTP_Response.StatusCode
         if ($HTTP_Status -eq 200) { 
            $GLOBAL:ValidURL=$True
         } else {
		   Write-Host "`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b                `b`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b" -NoNewLine
           Write-Warning ("  ** $element - the URL:`n              $url`n site might be OK, status code:" + $HTTP_Status)
		   if ($element -notmatch ".PS1"){
		        Write-Host "           ** Suggestion: Consider using CNC's -OpenURLs option to open and view all URLs in the .nuspec." -Foreground Cyan
		      } else {
		        Write-Host "           ** Suggestion: Check your download link, it appears to be bad." -Foreground Cyan
			   }
		   $GLOBAL:Suggestions++
		   $GLOBAL:ValidURL=$False
         }
         $HTTP_Response.Close()
        } catch {
          $HTTP_Status = [regex]::matches($_.exception.message, "(?<=\()[\d]{3}").Value
		  Write-Host "`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b                `b`b`b`b`b`b`b`b`b`b`b`b`b`b`b`b" -NoNewLine
          Write-Warning ("  ** $element - the URL:`n              $url`n              is probably bad, status code: " + $HTTP_Status)
		   if ($element -notmatch ".PS1"){
		        Write-Host "           ** Suggestion: Consider using CNC's -OpenURLs option to open and view all URLs in the .nuspec." -Foreground Cyan
		      } else {
		        Write-Host "           ** Suggestion: Check your download link, it appears to be bad." -Foreground Cyan
			   }
		  $GLOBAL:Suggestions++
		  $GLOBAL:ValidURL=$False
        }
   }
}

# Check for license files when binaries are included
function Check-LicenseFile{
  $LicenseFile=(Get-ChildItem -Path $path -Include *LICENSE* -Recurse)
  if ($LicenseFile){
	  Write-Host '           ** Binary files - (FYI)'$LicenseFile.Name'file(s) found.' -Foreground Green
	  $GLOBAL:FYIs++
	 } else {
	   Write-Host "           ** Binary files - LICENSE.txt file NOT found. This will trigger a message from the verifier:" -Foreground Red
	   Write-Host "           ** Requirements: Binary files (.exe, .msi, .zip, etc) have been included without including a LICENSE.txt`n              file. This file is required when including binaries " -Foreground Cyan
	   $GLOBAL:Required++
      }
}

# Check for verification file when binaries are included
function Check-VerificationFile{
  $VerificationFile=(Get-ChildItem -Path $path -Include *VERIFICATION* -Recurse)
  if ($VerificationFile){
      Write-Host '           ** Binary files - (FYI)'$VerificationFile.Name'file(s) found.' -Foreground Green
	  $GLOBAL:FYIs++
	} else {
	  Write-Host "           ** Binary files - VERIFICATION.txt file NOT found. This will trigger a message from the verifier:" -Foreground Red
	  Write-Host "           ** Requirements: Binary files (.exe, .msi, .zip) have been included without including a VERIFICATION.txt`n              file. This file is required when including binaries" -Foreground Cyan
	  $GLOBAL:Required++
    }
}

# check for binaries
function Check-Binaries{
  $IncludedBinaries=(Get-ChildItem -Path $path -Include $BinaryExtensions -Recurse)
  if ($IncludedBinaries){
      Write-Warning "  ** Binary files found in package. This will trigger a message from the verifier:"
      Write-Host "           ** Note: Binary files (.exe, .msi, .zip) have been included. The reviewer will ensure the maintainers have`n              distribution rights." -Foreground Cyan
	  $GLOBAL:Notes++
	  Check-LicenseFile
	  Check-VerificationFile
     }
}

# check for PNG files for possible optimization
function Check-PNGs{
  $PNGFiles=(Get-ChildItem -Path $path -Include *.PNG -Recurse)
  if ($PNGFiles){
      Write-Warning '  ** Binary files - FYI: PNG file(s) found.'
	  $GLOBAL:FYIs++
	  if (!$OptimizePNGs){
	  Write-Host '           ** Suggestion: Consider running CNC -OptimizePNGs to optimize your PNG file(s).' -Foreground Cyan
	  $GLOBAL:Suggestions++
	 }
    }
}

# check if header template is already in the description
function Check-Header{
  $NuspecDescription=$NuspecDescription.Trim()
  if ($NuspecDescription.StartsWith("***") -or $NuspecDescription.StartsWith("---") -or $NuspecDescription.StartsWith("___")){ 
      Write-Host "           ** <description> - FYI: header template found." -Foreground Green
	  $GLOBAL:FYIs++
	  $GLOBAL:FoundHeader=$True
     } else {
       $GLOBAL:FoundHeader=$False
	   }
}

# add header template to <description>
function Add-Header{
  if ($GLOBAL:FoundHeader){
      Write-Host "           ** <description> - FYI: header template previously added." -Foreground Cyan
	  $GLOBAL:FYIs++
	  return $NuspecDescription
	  }	
  if (Test-Path $CNCHeader){
      $Header=[IO.File]::ReadAllText($CNCHeader)
	  if ($Header -match '\$NuspecAuthors') {$Header=$Header -replace '\$NuspecAuthors',"$NuspecAuthors"}
	  if ($Header -match '\$NuspecID') {$Header=$Header -replace '\$NuspecID',"$NuspecID"}
	  if ($Header -match '\$NuspecOwners') {$Header=$Header -replace '\$NuspecOwners',"$NuspecOwners"}
	  if ($Header -match '\$NuspecTitle') {$Header=$Header -replace '\$NuspecTitle',"$NuspecTitle"}
      if ($Header -match '\$NuspecVersion') {$Header=$Header -replace '\$NuspecVersion',"$NuspecVersion"}
      $NuspecDescription="`n" + $Header + $NuspecDescription + "`n"
      Write-Host "           ** <description> - ADDED header template." -Foreground Green
	  $GLOBAL:UpdateNuspec=$True
	  $GLOBAL:Fixes++
	  return $NuspecDescription
    } else {
	  Write-Warning "           ** $CNCHeader not found."
	  return $NuspecDescription
     }
}

# check if footer template is already in the description
function Check-Footer{
  $NuspecDescription=$NuspecDescription.Trim()
  if ($NuspecDescription.EndsWith("***") -or $NuspecDescription.EndsWith("---") -or $NuspecDescription.EndsWith("___")){
      Write-Host "           ** <description> - FYI: footer template found." -Foreground Green
	  $GLOBAL:FYIs++
	  $GLOBAL:FoundFooter=$True
     } else {
       $GLOBAL:FoundFooter=$False
	  }
}

# add footer template to <description>
function Add-Footer{
  if ($GLOBAL:FoundFooter){
      Write-Host "           ** <description> - FYI: footer template previously added." -Foreground Cyan
	  $GLOBAL:FYIs++
	  return $NuspecDescription
	 }	
  if (Test-Path $CNCFooter){
      $Footer=[IO.File]::ReadAllText($CNCFooter)
	  if ($Footer -match '\$NuspecAuthors') {$Footer=$Footer -replace '\$NuspecAuthors',"$NuspecAuthors"}
	  if ($Footer -match '\$NuspecID') {$Footer=$Footer -replace '\$NuspecID',"$NuspecID"}
	  if ($Footer -match '\$NuspecOwners') {$Footer=$Footer -replace '\$NuspecOwners',"$NuspecOwners"}
	  if ($Footer -match '\$NuspecTitle') {$Footer=$Footer -replace '\$NuspecTitle',"$NuspecTitle"}
      if ($Footer -match '\$NuspecVersion') {$Footer=$Footer -replace '\$NuspecVersion',"$NuspecVersion"}
      $NuspecDescription=$NuspecDescription + "`n" + $Footer + "`n"
      Write-Host "           ** <description> - ADDED footer template." -Foreground Green
      $GLOBAL:UpdateNuspec=$True
	  $GLOBAL:Fixes++
	  return $NuspecDescription
    } else {
	  Write-Warning "           ** $CNCFooter NOT found."
	  return $NuspecDescription
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

# Run PNGOptimizerCL on PNG files
function Run-PNGOptimizer{
  if ($OptimizePNGs){
  if (!$PNGOptimizer){
      Write-Warning "  ** -OptimizePNGs parameter given but PNGOptimizerCL.exe not found."
	  Write-Host "           ** Run choco install pngoptimizer.commandline first to use this feature." -Foreground Cyan
	  return
     }
  $PNGFiles=(Get-ChildItem -Path $path -Include *.PNG -Recurse)
  if ($PNGFiles -and $PNGOptimizer){
      Write-Host "           ** Running PNGOptimzerCL on PNG files." -Foreground Green
	  if ($WhatIf){
          Write-Host "CNC did NOT optimize your PNG files, -WhatIf parameter was used." -Foreground Magenta
	    } else {
# need to strip trailing \ ?
          Get-ChildItem $path\*.PNG -Recurse | % $_.file {& pngoptimizercl.exe -file:$_}
		  $GLOBAL:Fixes++
#		 &PngOptimizerCL.exe -file:$path\*.png -recurs #| Out-Null
		 }
  }
 }
}

# Convert RawGit and non-CDN URLs to supported CDN URLs
function Update-CDNURL([string]$oldURL){
  if ($StaticlyCDN){
      if ($oldURL -match 'https://raw.githubusercontent.com'){$StaticalyURL=($oldURL -replace 'https://raw.githubusercontent.com','https://cdn.staticaly.com/gh')}
      if ($oldURL -match 'https://cdn.rawgit.com'){$StaticalyURL=($oldURL -replace 'https://cdn.rawgit.com','https://cdn.staticaly.com/gh')}
      $GLOBAL:UpdateNuspec=$True
      $GLOBAL:Fixes++
      return $StaticalyURL
    }
  if ($GitCDN){
      if ($oldURL -match 'https://raw.githubusercontent.com'){$GitCNDURL=($oldURL -replace 'https://raw.githubusercontent.com','https://gitcdn.link/repo')}
      if ($oldURL -match 'https://cdn.rawgit.com'){$GitCNDURL=($oldURL -replace 'https://cdn.rawgit.com','https://gitcdn.link/repo')}
      $GLOBAL:UpdateNuspec=$True
      $GLOBAL:Fixes++
      return $GitCNDURL
     }
  if ($GitHackCDN){
      if ($oldURL -match 'https://raw.githubusercontent.com'){$GitHackURL=($oldURL -replace 'https://raw.githubusercontent.com','https://rawcdn.githack.com')}
      if ($oldURL -match 'https://cdn.rawgit.com'){$GitHackURL=($oldURL -replace 'https://cdn.rawgit.com','https://rawcdn.githack.com')}
      $GLOBAL:UpdateNuspec=$True
      $GLOBAL:Fixes++
      return $GitHackURL
     }
  if ($jsDelivrCDN){
# this will fail if link is not to the master branch  
      if ($oldURL -match 'https://raw.githubusercontent.com'){
          $jsDelivrURL=($oldURL -replace 'https://raw.githubusercontent.com','https://cdn.jsdelivr.net/gh')
	      $jsDelivrURL=($jsDelivrURL -replace 'master/','')
	     }
      if ($oldURL -match 'https://cdn.rawgit.com'){
          $jsDelivrURL=($oldURL -replace 'https://cdn.rawgit.com','https://cdn.jsdelivr.net/gh')
	      $jsDelivrURL=($jsDelivrURL -replace 'master/','')
	     }
      $GLOBAL:UpdateNuspec=$True
      $GLOBAL:Fixes++
      return $jsDelivrURL
    }
}

# Update the nuspec XML declaration with encoding info
function Update-XMLDeclaration{
  Write-Host "           ** XML declaration changed to version=""1.0"" encoding=""utf-8""" -Foreground Green
  $nuspecFile.xml="version=""1.0"" encoding=""utf-8"""
  $GLOBAL:Fixes++
  $GLOBAL:UpdateNuspec=$True
}

# Update the nuspec with any changes and save as UTF-8 w/o BOM
# Thanks https://stackoverflow.com/questions/8160613/powershell-saving-xml-and-preserving-format
Function Update-nuspec{
  if ($GLOBAL:UpdateNuspec){
      $UpdatednuspecFile = [xml]([System.IO.File]::ReadAllText($LocalnuspecFile))
      $UpdatednuspecFile.PreserveWhitespace = $true
      $settings = New-Object System.Xml.XmlWriterSettings
      $settings.Indent = $true
      $settings.NewLineChars ="`r`n"
      $settings.Encoding = New-Object System.Text.UTF8Encoding($false)   
# changes
      if ($UpdateXMLComment -and !$nuspecFile.'#comment'){$UpdatednuspecFile.InsertAfter($UpdatednuspecFile.CreateComment($XMLComment), $UpdatednuspecFile.FirstChild) | Out-Null}
      if ($nuspecFile.xml){$UpdatednuspecFile.xml = $nuspecFile.xml}
      if ($nuspecFile.package.metadata.description.'#cdata-section'){
#         $NuspecDescription.'#cdata-section' = $NuspecDescription
#         Write-Host "           ** <description> - CDATA found, not changing it." -Foreground Magenta
        } else {
          $UpdatednuspecFile.package.metadata.description=$NuspecDescription
	     }
      if ($NuspecIconURL){$UpdatednuspecFile.package.metadata.iconurl=$NuspecIconURL}
      if ($MakeBackups){Copy-Item "$LocalnuspecFile" "$LocalnuspecFile.CNC.bak" -Force}
      $xfile = [System.Xml.XmlWriter]::Create($LocalnuspecFile, $settings)
      try{
        $UpdatednuspecFile.Save($xfile)
      } finally {
        $xfile.Dispose()
      }
  }
}

# checks PowerShell scripts for $ErrorActionPreference statement
function Check-PS1EAP($ScriptFile){
    $CheckEAP=Get-Content $ScriptFile -First 5
  if ($checkEAP -match '\$ErrorActionPreference') {
      return $True
     } else {
	   $ScriptFile=(Get-Item $ScriptFile).Name
	   $ScriptFile=$ScriptFile.toupper()
	   if ($UpdateScripts){
	       Write-Host "           ** $ScriptFile - recommended ErrorActionPreference statement has been added." -Foreground Green
	   } else {
         Write-Warning "  ** $ScriptFile - is missing the recommended ErrorActionPreference statement."	   
         Write-Host "           ** Suggestion: Consider running CNC -UpdateScripts to add it." -Foreground Cyan
         $GLOBAL:Suggestions++
	     return $False
	   }
    }
}

# Add EAP statement to top of PowerShell script
function Add-PS1EAP($ScriptFile){
  if ($UpdateScripts -and !$WhatIf){
      if ($MakeBackups){Copy-Item "$ScriptFile" "$ScriptFile.CNC.bak" -Force}
      $header = "`$ErrorActionPreference = 'Stop'"
      $Body=Get-Content $ScriptFile
      $NewContent=$header+$Body
      Write-Output $header $body | Out-File $ScriptFile
	  $GLOBAL:Fixes++
	  }
}

# Re-write PS script as UTF-8 w/BOM
function Update-PS1($ScriptFile){
  if ($UpdateScripts -and !$WhatIf){
      if ($MakeBackups){Copy-Item "$ScriptFile" "$ScriptFile.CNC.bak" -Force}
#	  Write-Host "           ** $ScriptFile - will be converted to UTF-8 w/ BOM and saved." -Foreground Green
      $Body=Get-Content $ScriptFile
      Write-Output $Body | Out-File $ScriptFile
	  $GLOBAL:Fixes++
	  }
}

# Check chocolateyInstall.ps1 for SourceForge download links
function Check-SourceForge{
if (Test-Path $path\tools\chocolateyInstall.ps1){
   $test=Get-Content $path\tools\chocolateyInstall.ps1
    if ($test -match "sourceforge"){
        Write-Warning "  ** CHOCOLATEYINSTALL.PS1 uses SourceForge as download source. This will trigger a message from the verifier:"
	    Write-Host "           ** Guideline: Using SourceForge as the download source of installers is not recommended. Please consider an`n              alternative, official distribution location if one is available." -Foreground Cyan
	    $GLOBAL:Guidelines++
       }
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
	if ($GLOBAL:UpdateNuspec) {
	     Write-Host "           ** $NuspecDisplayName will be converted to UTF-8 w/o BOM and saved." -Foreground Green
		 $GLOBAL:Fixes++
		 } else {
		   Write-Host "           ** Guideline: You must save your files with UTF–8 character encoding without BOM." -Foreground Cyan
		   $GLOBAL:Guidelines++
		   Write-Host "           ** Suggestion: Consider running CNC -Update to re-write`n              $LocalnuspecFile to UTF-8 w/o BOM." -Foreground Cyan
		   $GLOBAL:Suggestions++
	}
}

# check XML declaration
if ($nuspecFile.xml -eq "version=""1.0"""){
    Write-Warning "  ** XML declaration is version=""1.0"""
	if ($UpdateXMLDeclaration){
	    Update-XMLDeclaration
	} else {
      Write-Host "           ** Suggestion: Consider running CNC -UpdateXMLDeclaration to add a UTF-8 encoding statement." -Foreground Cyan
	  $GLOBAL:Suggestions++
	}
}

# check XML comment
if (!$nuspecFile.'#comment'){
    if ($UpdateXMLComment){
	    Write-Host "           ** XML comment to test UTF-8 encoding added." -Foreground Green
	    $GLOBAL:Fixes++
	    $GLOBAL:UpdateNuspec=$True
	} else {
      Write-Warning "  ** The recommended XML comment to test UTF-8 encoding was not found."	
      Write-Host "           ** Suggestion: Consider running CNC -UpdateXMLComment to add a UTF-8 encoding test XML comment." -Foreground Cyan
	  $GLOBAL:Suggestions++
	  if ($nuspecFile.'#comment' -match "Read this before creating packages"){
          Write-Host "  ** XML comment contains templated values. This will trigger a message from the verifier:" -Foreground Red
          Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
          $GLOBAL:Required++
	  }
	 }
}

# <authors> checks
if (!($NuspecAuthors)) {
    Write-Host "           ** <authors> element is empty, this element is a requirement." -Foreground Red
	$GLOBAL:Required++
   } else {
     if ($NuspecAuthors -match "@"){
	     Write-Host "           ** <authors> - contains an e-mail address. This will trigger a message from the verifier:" -Foreground Red
	     Write-Host '           ** Requirements: Email address should not be used in the Author and Copyright fields of the nuspec file. ' -Foreground Cyan
		 $GLOBAL:Required++
	    }
	 if ($NuspecAuthors -cmatch "REPLACE"){
         Write-Host "  ** <authors> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
		}
   }

# <bugTrackerUrl> checks
if (!($NuspecBugTrackerURL)) {
     Write-Warning "  ** <bugTrackerUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: bugTrackerUrl - points to the location where issues and tickets can be accessed' -Foreground Cyan
	$GLOBAL:Suggestions++
   } else {
     Validate-URL "<bugTrackerUrl>" $NuspecBugTrackerURL
	}

# <conflicts> checks - Built for the future
#if (!($NuspecConflicts)) {Write-Warning "  ** <conflicts> element is empty."}

# <copyright> checks
if (!($NuspecCopyright)) {
    Write-Warning "  ** <copyright> - FYI: element is empty."
	$GLOBAL:FYIs++
	} else {
	  if ($NuspecCopyright.Length -lt 5) {
	      Write-Host "           ** <copyright> - is less than 4 characters. This will trigger a message from the verifier:" -Foreground Red
		  Write-Host '           ** Requirements: If you are going to use copyright in the nuspec, please use more than 4 characters.' -Foreground Cyan
		  $GLOBAL:Required++
		  }
	  if ($NuspecAuthors -match "@"){
	      Write-Host "           ** <copyright> - contains an e-mail address. This will trigger a message from the verifier:" -Foreground Red
	      Write-Host '           ** Requirements: Email address should not be used in the Author and Copyright fields of the nuspec file. ' -Foreground Cyan
          $GLOBAL:Required++
	 }
	 if ($NuspecCopyright -eq "Year Software Vendor"){
         Write-Host "  ** <copyright> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
	    }
	}

# <dependencies> checks
if (!($NuspecDependencies)) {
    Write-Warning "  ** <dependencies> - FYI: element is empty."
	$GLOBAL:FYIs++
   } else {
     if ((!$NuspecDependencies) -and ($NuspecTitle -match "deprecated")){
	      Write-Host "           ** <dependencies> - Deprecated packages must have a dependency." -Foreground Red
		  $GLOBAL:Required++
		  }
	 if ($NuspecDependencies.dependency.id -eq 'chocolatey'){
	     Write-Warning "  ** <dependencies> - ""chocolatey"" is a dependency. This will trigger a message from the verifier:"
	     Write-Host "           ** Note: The package takes a dependency on Chocolatey. The reviewer will ensure the package uses a specific`n              Chocolatey feature that requires a minimum version." -Foreground Cyan
		 $GLOBAL:Notes++
		 }
	 $DependencyName=$NuspecDependencies.dependency.id
	 if ($NuspecDependencies.dependency.id.count -eq 1){
    	 if ($NuspecDependencies.dependency.version -eq $null){
	          Write-Warning "  ** <dependencies> - $DependencyName has no version. This will trigger a message from the verifier:"
      	      Write-Host "           ** Guideline: Package contains dependencies with no specified version. You should at least specify`n              a minimum version of a dependency." -Foreground Cyan
			  $GLOBAL:Guidelines++
	         }
	 } else {
	   $DependencyNumber=0
	 do{
	    $DependencyName=$NuspecDependencies.dependency.id[$DependencyNumber]
 	    if ($NuspecDependencies.dependency[$DependencyNumber].version -eq $null){
				Write-Warning "  ** <dependencies> - ""$DependencyName"" has no version. This will trigger a message from the verifier:"
			    Write-Host "           ** Guideline: Package contains dependencies with no specified version. You should at least specify`n              a minimum version of a dependency." -Foreground Cyan
				$GLOBAL:Guidelines++
			}
	   $DependencyNumber++
       } while ($DependencyNumber -lt $NuspecDependencies.dependency.id.count)
	 }
}

# <description> checks
if ($NuspecDescription.'#cdata-section'){
    $NuspecDescription=$nuspecFile.package.metadata.description.'#cdata-section'
   }
if (!$NuspecDescription){
    Write-Host "           ** <description> - element is empty, this element is a requirement." -Foreground Red
	$GLOBAL:Required++
   } else {
     Check-Header
	 if ($AddHeader) {
         $NuspecDescription=(Add-Header)
        }
     Check-Footer
	 if ($AddFooter) {
         $NuspecDescription=(Add-Footer)
        }
     if ($NuspecDescription.Length -lt 30) {
	     Write-Warning "  ** <description> - is less than 30 characters." 
		 $GLOBAL:Guidelines++
		 }
     if ($NuspecDescription.Length -gt 4000) {
	     Write-Host "           ** <description> - is greater than 4,000 characters. Pushing the package will generate the error:" -Foreground Red
		 Write-Host "           ** Failed to process request. 'This package had an issue pushing: A nuget package's Description property may`n              not be more than 4000 characters long.'. The remote server returned an error: (409) Conflict.." -Foreground Cyan
		 $GLOBAL:Required++
		 }
	 if ($NuspecDescription -match "raw.githubusercontent"){
		 if ($UpdateImageURLs){
#             Write-Warning "  ** <description> - includes a GitHub raw link."
			 Write-Host "           ** <description> - URL(s) updated to use $NewCDN." -Foreground Green
             $NuspecDescription=(Update-CDNURL "$NuspecDescription")
		 } else {
		   Write-Warning "  ** <description> - includes a GitHub raw link. Please change to a CDN such as:"
           Write-Host "           ** $CDNlist" -Foreground Cyan
		   Write-Host "           ** Suggestion: Consider running CNC -UpdateImageURLs to update it." -Foreground Cyan
		   $GLOBAL:Suggestions++
          }
	   }
     if ($NuspecDescription -match "cdn.rawgit.com"){
		 if ($UpdateImageURLs){
#             Write-Warning "  ** <description> - includes a link to RawGit which will be going offline October 2019."
			 Write-Host "           ** <description> - URL(s) updated to use $NewCDN." -Foreground Green
             $NuspecDescription=(Update-CDNURL "$NuspecDescription")
		 } else {
		   Write-Warning "  ** <description> - includes a link to RawGit which will be going offline October 2019. Please change to a`n              CDN such as:"
           Write-Host "           ** $CDNlist" -Foreground Cyan
		   Write-Host "           ** Suggestion: Consider running CNC -UpdateImageURLs to update it." -Foreground Cyan
		   $GLOBAL:Suggestions++
		 }
       }
	  if ($NuspecDescription -cmatch "REPLACE"){
          Write-Host "  ** <description> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
          Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
          $GLOBAL:Required++
	     }
# below checking doesn't work as PowerShell will already give an error reading the nuspec
# Cannot convert value "System.Object[]" to type "System.Xml.XmlDocument". Error: "An error occurred while parsing
# EntityName.
	 if ($NuspecDescription -match ' `& '){
	     Write-Warning "  ** <description> - `& found and needs to be replaced with `&amp;"
		 Write-Host "           ** Packing will error: ""An error occurred while parsing EntityName.""" -Foreground Red
		 if ($UpdateAll){
             $NuspecDescription=$NuspecDescription -replace "`&","`&amp;"
             Write-Host "           ** <description> - `& replaced with `&amp;" -Foreground Green
			 $GLOBAL:Fixes++
		    } else {
			  Write-Host "           ** Suggestion: Consider running CNC -UpdateAll to update it." -Foreground Cyan
			  $GLOBAL:Suggestions++
			  $GLOBAL:Required++
			 }
       }
     if (($nuspecFile.package.metadata.description.'#cdata-section') -and ($GLOBAL:UpdateNuspec)){
        Write-Host "           ** <description> - CDATA found, not saving description changes." -Foreground Magenta
       } 
}

# <docsUrl> checks
if (!($NuspecDocsURL)) {
    Write-Warning "  ** <docsUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: docsUrl - points to the location of the wiki or docs of the software' -Foreground Cyan
	$GLOBAL:Suggestions++
   } else {
     if ($NuspecDocsURL -match "docs located"){
	     Write-Host "  ** <docsUrl> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
		} else {
		  Validate-URL "<docsUrl>" $NuspecDocsURL
		 }
}

# <files> checks
if (!($NuspecFiles)) {
    Write-Warning "  ** <files> - FYI: element is empty. All of the following files will be packaged:"
    Get-ChildItem -Path $path -Recurse -Exclude *.nupkg,tools |% $_.file {Write-Host "           ** $_" -Foreground Cyan -ea SilentlyContinue}
	$GLOBAL:FYIs++
}

# <iconUrl> checks
if (!($NuspecIconURL)) {
    Write-Warning "  ** <iconUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Guideline: The iconUrl should be added if there is one. Please correct this in the nuspec, if applicable.' -Foreground Cyan
	$GLOBAL:Guidelines++
   } else {
     if ($NuspecIconURL -cmatch "REPLACE"){
	     Write-Host "  ** <iconUrl> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
		}
     Validate-URL "<iconUrl>" $NuspecIconURL
	 if ($GLOBAL:ValidURL){
	     Get-ImageDimensions
	    }
	 $IconExt=($NuspecIconURL | Select-String -Pattern $AcceptableIconExts)
     if (!($IconExt)){
	     Write-Warning "  ** <iconUrl> - Your package icon is NOT a .PNG or .SVG. This will trigger a message from the verifier:"
	     Write-Host '           ** Suggestion: As per the packaging guidelines icons should be either a png or svg file.' -Foreground Cyan
	     $GLOBAL:Suggestions++
       }
	 if ($NuspecIconURL -match "raw.githubusercontent"){
         if ($UpdateImageURLs) {
		    $NuspecIconURL=(Update-CDNURL "$NuspecIconURL")
			Write-Host "           ** <iconUrl> - URL updated to: `n              $NuspecIconURL" -Foreground Green
		   } else {
		     Write-Warning "  ** <iconUrl> - uses a GitHub raw link. Please use a CDN such as:"
             Write-Host "           ** $CDNlist" -Foreground Cyan		   
		     Write-Host "           ** Suggestion: Consider running CNC -UpdateImageURLs to update it." -Foreground Cyan
			 $GLOBAL:Suggestions++
		   }
		}
     if ($NuspecIconURL -match "cdn.rawgit.com"){
         if ($UpdateImageURLs) {
		     $NuspecIconURL=(Update-CDNURL "$NuspecIconURL")
			 Write-Host "           ** <iconUrl> - URL updated to: `n              $NuspecIconURL" -Foreground Green
		   } else {
		     Write-Warning "  ** <iconUrl> - uses RawGit which will be going offline October 2019. Please change to a CDN such as:"
             Write-Host "           ** $CDNlist" -Foreground Cyan
		     Write-Host "           ** Suggestion: Consider running CNC -UpdateImageURLs to update it." -Foreground Cyan
			 $GLOBAL:Suggestions++
		   }
       }
}

# <id> checks
if (!($NuspecID)) {
    Write-Host "           ** <id> - element is empty, this element is a requirement." -Foreground Red
	$GLOBAL:Required++
	} else {
     if (($NuspecID.Length -gt 20) -and (!$NuspecID.Contains("-")) -and (!$NuspecID.Contains("."))) {
	     Write-Warning "  ** <id> - is greater than 20 characters. This will trigger a message from the verifier:"
	     Write-Host "           ** Note: If this is a new package that has never been approved, moderators will review and reject the`n              package for one that will be pushed with a new id that meets the package naming guidelines." -Foreground Cyan
		 $GLOBAL:Notes++
	    }
	 if ($NuspecID -cmatch "[A-Z]") {
	     Write-Warning "  ** <id> - includes UPPERcase letters."
		 $GLOBAL:Guidelines++
		}
	 if (($NuspecID.Contains(".")) -and (!$NuspecID.Contains(".install")) -and (!$NuspecID.Contains(".portable")) -and (!$NuspecID.Contains(".extension"))) {
	      Write-Warning "  ** <id> - includes a '.'. This will trigger a message from the verifier:"
		  Write-Host "           ** Note: The package id includes dots (.). Usually the package id is separated by '-' instead of dots`n              (except in the case of *.install and *.portable). The reviewer will ensure this is not a new package."  -Foreground Cyan
		  $GLOBAL:Notes++
		 }
	 if ($NuspecID.Contains(".config")){
	      Write-Host "           ** <id> - includes a '.config'. This is not allowed." -Foreground Red
		  $GLOBAL:Required++
		 }
}

# <licenseUrl> checks
if (!($NuspecLicenseURL)) {
    Write-Warning "  ** <licenseUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host "           ** Guideline: The licenseUrl should be added if there is one. Please correct this in the nuspec,`n              if applicable." -Foreground Cyan
	$GLOBAL:Guidelines++
   } else {
     if ($NuspecLicenseURL -eq $NuspecprojectUrl) {
         Write-Warning "  ** <licenseUrl> - is the same as <projectUrl>. This will trigger a message from the verifier:"
	     Write-Host "           ** Guideline: The licenseUrl should not usually be an exact match to softwareUrl. Please correct this in the`n              nuspec, if applicable. ." -Foreground Cyan
	     $GLOBAL:Guidelines++
		}
     if ($NuspecLicenseURL -cmatch "REMOVE"){
         Write-Host "  ** <licenseUrl> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
		} else {
          Validate-URL "<licenseUrl>" $NuspecLicenseURL
		 }
}	

# <mailingListUrl> checks
if (!($NuspecMailingListURL)) {
    Write-Warning "  ** <mailingListUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: mailingListUrl - points to the forum or email list group for the software' -Foreground Cyan
	$GLOBAL:Suggestions++
   } else {
     Validate-URL "<mailingListUrl>" $NuspecMailingListURL
	}
	
# <owners> checks
if (!($NuspecOwners)) {
    Write-Host "  ** <owners> element is empty, this element is a requirement." -Foreground Red
	$GLOBAL:Required++
   } else {
     if ($NuspecID -cmatch "REPLACE"){
         Write-Host "  ** <owners> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
	    }
     if ($NuspecAuthors -eq $NuspecOwners){
        Write-Warning "  ** <owners> and <authors> elements are the same. This will trigger a message from the verifier:"
        Write-Host "           ** Note: The package maintainer field (owners) matches the software author field (authors) in the nuspec.`n              The reviewer will ensure that the package maintainer is also the software author." -Foreground Cyan
		$GLOBAL:Notes++
		}
   }

# <packageSourceUrl> checks
if (!($NuspecPackageSourceURL)) {
    Write-Warning "  ** <packageSourceUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host "           ** Guideline: The nuspec has been enhanced to allow packageSourceUrl, pointing to the url where the package`n              source resides. This is a strong guideline because it simplifies collaboration.`n              Please add it to the nuspec." -Foreground Cyan
	$GLOBAL:Guidelines++
   } else {
     if ($NuspecPackageSourceURL -cmatch "packageSourceUrl"){
	     Write-Host "  ** <packageSourceUrl> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
		} else {
          Validate-URL "<packageSourceUrl>" $NuspecPackageSourceURL
		 }
	}

# <projectSourceUrl> checks
if (!$NuspecProjectSourceURL) {
    Write-Warning "  ** <projectSourceUrl> - element is empty. This will trigger a message from the verifier:"
	Write-Host '           ** Suggestion: projectSourceUrl - points to the location of the underlying software source' -Foreground Cyan
	$GLOBAL:Suggestions++
   } else {
     if ($NuspecProjectSourceURL -match "Software Source Location"){
         Write-Host "  ** <projectSourceUrl> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
		} else {
          Validate-URL "<projectSourceUrl>" $NuspecProjectSourceURL
		 }
	 if ($NuspecProjectURL -eq $NuspecProjectSourceURL){
         Write-Warning "  ** <projectUrl> and <projectSourceUrl> elements are the same. This will trigger a message from the verifier:"
         Write-Host "           ** Guideline: ProjectUrl and ProjectSourceUrl are typically different, but not always. Please ensure`n              that projectSourceUrl is pointing to software source code or remove the field from the nuspec." -Foreground Cyan
		 $GLOBAL:Guidelines++
       }
	}
	
# <projectUrl> checks
if (!($NuspecProjectURL)) {
    Write-Host "           ** <projectUrl> - element is empty. This will trigger a message from the verifier:" -Foreground Red
    Write-Host "           ** Requirement: ProjectUrl (projectUrl) in the nuspec file is required. Please add it to the nuspec." -Foreground Cyan
	$GLOBAL:Required++
   } else {
     if ($NuspecProjectURL -cmatch "REMOVE"){
         Write-Host "  ** <projectUrl> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
	   } else {
         Validate-URL "<projectUrl>" $NuspecProjectURL
	    }
	}	

# <provides> checks - Built for the future
#if (!($NuspecProvides)) {Write-Warning "  ** <provides> element is empty"}

# <releaseNotes> checks
if (!($NuspecReleaseNotes)) {
    Write-Warning "  ** <releaseNotes> - element is empty. This will trigger a message from the verifier:"
	Write-Host "           ** Guideline: Release Notes (releaseNotes) are a short description of changes in each version of a package.`n              Please include releasenotes in the nuspec. NOTE: To prevent the need to continually update this field,`n              providing a URL to an external list of Release Notes is perfectly acceptable." -Foreground Cyan
	$GLOBAL:Guidelines++
   } else {
     if ($NuspecReleaseNotes -cmatch "REPLACE"){
         Write-Host "  ** <releaseNotes> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
	    }
	 }

# <replaces> checks - Built for the future
#if (!($NuspecReplaces)) {Write-Warning "  ** <replaces> element is empty."}

# <requireLicenseAcceptance> checks
if (!($NuspecRequireLicenseAcceptance)) {
    Write-Warning "  ** <requireLicenseAcceptance> - FYI: element is empty."
	$GLOBAL:FYIs++
	} else {
	  if (($NuspecRequireLicenseAcceptance -eq "true") -and (!($NuspecLicenseURL))) {
	      Write-Host "           ** <requireLicenseAcceptance> is set to true but <licenseUrl> is empty." -Foreground Red
		  $GLOBAL:Required++
		  }
	  }

# <summary> checks
if (!($NuspecSummary)) {
    Write-Warning "  ** <summary> - element is empty. This will trigger a message from the verifier:"
    Write-Host '           ** Guideline: Summary (summary) is a short explanation of the software. Please include summary in the nuspec.' -Foreground Cyan
	$GLOBAL:Guidelines++
	} else {
	  if ($NuspecSummary -cmatch "REPLACE"){
          Write-Host "  ** <summary> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
          Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
          $GLOBAL:Required++
		 }
     }

# <tags> checks
if (!($NuspecTags)) {
     Write-Host "           ** <tags> - element is empty." -Foreground Red
	 $GLOBAL:Required++
	} else {
	  if ($NuspecTags -match ","){
         Write-Host "           ** <tags> - tags are separated with commas. They should only be separated with spaces." -Foreground Red
		 $GLOBAL:Required++
		}
	  if ($NuspecTags -match "admin"){
         Write-Warning "  ** <tags> - FYI: there is a tag named ""admin"" which is now deemed unnecessary."
         Write-Host '           ** The majority of Chocolatey packages require admin rights to install, this is considered default behavior.' -Foreground Cyan
		 $GLOBAL:FYIs++
		}	
	  if ($NuspecTags -match "chocolatey"){
         Write-Warning "  ** <tags> - there is a tag named ""chocolatey"" which will trigger a message from the verifier:"
         Write-Host '           ** Guideline: Tags (tags) should not contain 'chocolatey' as a tag. Please remove that in the nuspec.' -Foreground Cyan
		 $GLOBAL:Guidelines++
		}
	  if ($NuspecTags -match "notsilent"){
         Write-Warning "  ** <tags> - there is a tag named ""notsilent"" which will trigger a message from the verifier:"
         Write-Host '           ** Note: notSilent tag is being used. The reviewer will ensure this is being used appropriately. ' -Foreground Cyan
		 $GLOBAL:Notes++
		}
	  if ($NuspecTags -cmatch "SEPARATED"){
          Write-Host "  ** <tags> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
          Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
          $GLOBAL:Required++
		 }
    }

# <title> checks
if (!($NuspecTitle)) {
    Write-Warning "  ** <title> - element is empty."
	$GLOBAL:Guidelines++
   } else {
     if ($NuspecTitle -eq $NuspecID){
	     Write-Warning "  ** <title> and <id> are the same which will trigger a message from the verifier:"
		 Write-Host "           ** Guideline: Title (title) matches id exactly. Please consider using something slightly more descriptive`n              for the title in the nuspec." -Foreground Cyan
		 $GLOBAL:Guidelines++
	   }
   }

# <version> checks
if (!($NuspecVersion)) {
    Write-Host "           ** <version> - element is empty, this element is a requirement." -Foreground Red
	$GLOBAL:Required++
	} else {
	  if ($NuspecVersion -match "REPLACE"){
          Write-Host "  ** <version> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
          Write-Host "  ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
          $GLOBAL:Required++
		 }
	  }

#### BUG: error when run via Get-ChildItem | ?{if ($_.PSIsContainer){cls;cd $_.Name;cnc;cd ..;pause}} ###
#% : Input name "(dir name or package name)" cannot be resolved to a method.
#At C:\ProgramData\chocolatey\bin\CNC.ps1:1198 char:40
#+ Get-ChildItem "$path\*.ps1" -Recurse | % $_ {
#+                                        ~~~~~~
#    + CategoryInfo          : InvalidArgument: (S:\dev\GitHub\C...ateyinstall.ps1:PSObject) [ForEach-Object],PSArgumentException
#    + FullyQualifiedErrorId : MethodNotFound,Microsoft.PowerShell.Commands.ForEachObjectCommand

# check PowerShell script files, out of scope, but nice to have
# This should probably be broken down into small functions
Get-ChildItem "$path\*.ps1" -Recurse | % $_ {
if ($debug){
write-host "PATH = $path" -foreground red -background white
write-host "FOREACH = $_" -foreground red -background white
}
		  $ScriptFile=(Get-Item $_).Name
		  $ScriptFile=$ScriptFile.toupper()
          $HasPS1EAP=Check-PS1EAP $_ 
		  if (!$HasPS1EAP){
               Add-PS1EAP $_
			   }
          $PS1Encoding=Get-FileEncoding $_
		  if ($PS1Encoding -ne 'UTF-8 w/ BOM'){
		      if (!$UpdateScripts){
		          Write-Warning "  ** $ScriptFile - is encoded using $PS1Encoding."
			      Write-Host "           ** PowerShell scripts need to be saved in UTF–8 with BOM." -Foreground Cyan
		          Write-Host "           ** Suggestion: Consider running CNC -UpdateScripts to re-write $ScriptFile to UTF-8 w/ BOM." -Foreground Cyan
			      $GLOBAL:Suggestions++
			  } else {
			    Write-Host "           ** $ScriptFile - will be converted to UTF-8 w/ BOM and saved." -Foreground Green
			    Update-PS1 $_
			  }
	         }
		  $ScriptError=Test-PowerShellSyntax ($_)
		  if ($ScriptError.SyntaxErrorsFound){
		      Write-Host "           ** $ScriptFile - has PowerShell syntax errors." -Foreground Red
			  $GLOBAL:Required++
			 }
          if ($_ -match "install"){
              $count=0
              $InstallScript=Get-Content $_
              $urlsfound = @()
              $InstallScript | foreach-object {
                 if ($_ -match "\b(?:(?:https?|ftp|file)://|www\.|ftp\.)(?:\([-A-Z0-9+&@#/%=~_|$?!:,.]*\)|[-A-Z0-9+&@#/%=~_|$?!:,.])*(?:\([-A-Z0-9+&@#/%=~_|$?!:,.]*\)|[A-Z0-9+&@#/%=~_|$])"){
                   $urlsfound += $matches[0]
	               $validateurl=$urlsfound[$count]
                   Validate-URL "$ScriptFile" "$validateurl"
	               $count++
                  }
              }
          }
}

# SourceForge DL link check
Check-SourceForge

# Binaries checks
Check-Binaries

#PNG checks
Check-PNGs

# Git 'er done ------------------------------------------------------------------------------------------------

# Optimize any PNG files
Run-PNGOptimizer

Write-Host "CNC found " -NoNewLine -Foreground Magenta
Write-Host "$GLOBAL:Required REQUIRED changes, " -NoNewLine -Foreground Red
Write-Host "$GLOBAL:Guidelines GUIDELINE changes, " -NoNewLine -Foreground Yellow
Write-Host "$GLOBAL:Suggestions SUGGESTED changes, " -NoNewLine -Foreground Yellow
Write-Host "$GLOBAL:Notes NOTES, " -NoNewLine -Foreground Yellow
Write-Host "$GLOBAL:FYIs FYIs, " -NoNewLine -Foreground Yellow
Write-Host "and made $GLOBAL:Fixes changes." -ForeGround Green

if ($GLOBAL:UpdateNuspec) {
   if ($WhatIf){
        Write-Host "CNC did NOT update $LocalnuspecFile, -WhatIf parameter was used." -Foreground Magenta
   } else {
	Update-nuspec
	}
}

if ($UpdateScripts) {
   if ($WhatIf){
        Write-Host "CNC did NOT update your scripts, -WhatIf parameter was used." -Foreground Magenta
   }
}

Write-Host "`nFound CNC.ps1 useful?" -Foreground White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -Foreground White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -Foreground White
return

# TDL
#BUG: script checking has error when run via Get-ChildItem | ?{if ($_.PSIsContainer){cls;cd $_.Name;cnc;cd ..;pause}}
# check for &'s in links to change to &amp;
# option of displaying useful tips and tweaks (AutoHotKey, BeCyIconGrabber, PngOptimizer, Regshot, service viewer program, Sumo, etc)
# MAYBE redo file selection by filename instead of directory and implement a -Recurse option - medium low priority
# MAYBE do full params statement and get rid of args checking - low priority
# MAYBE check http links to see if https links are available and report if so - low priority
# MAYBE check $nuspecFile.package.xmlns and re-write if old (not sure if this is a good idea)
# MAYBE edit and re-write handling CDATA in description (not sure if there is a need)
# https://github.com/chocolatey/package-validator/wiki/PackageInternalFilesIncluded
# https://github.com/chocolatey/package-validator/wiki/InstallScriptNamedCorrectly
# https://github.com/chocolatey/package-validator/wiki/ScriptsDoNotContainChocoCommands
# https://github.com/chocolatey/package-validator/wiki/ChecksumShouldBeUsed
# What else?
