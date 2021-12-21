# $ErrorActionPreference = 'Stop'
# CNC.ps1 Copyleft 2018-2021 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

# REF: https://docs.microsoft.com/en-us/nuget/reference/nuspec
# REF: https://docs.chocolatey.org/en-us/community-repository/moderation/package-validator/rules/

<#
.SYNOPSIS
   Script to check your Chocolatey .nuspec files for common errors and ommisions.
.DESCRIPTION
   TODO
.EXAMPLE
    cnc
    To check the package in your current directory
.EXAMPLE
    cnc -UpdateAll
    Fix the package in your current directory
.EXAMPLE
    cnc -Recurse -Path C:\Path\To\Packages\Repo
    To check all the packages in a package sources repository

.PARAMETER help
   Displays this information.
.PARAMETER ?
   Displays this information.
.PARAMETER AddFooter
   Adds and saves a footer from $CNCFooter to your <description>.
.PARAMETER AddHeader
   Adds and saves a header from $CNCHeader to your <description>.
.PARAMETER AddPackageNotes
   Adds and saves a package notes link from $CNCPackageNotes to your <description>.
.PARAMETER EditFooter
   Edit $CNCFooter with Notepad++ or Notepad.
.PARAMETER EditHeader
   Edit $CNCHeader with Notepad++ or Notepad.
.PARAMETER EditPackageNotes
   Edit $CNCPackageNotes with Notepad++ or Notepad.
.PARAMETER MakeBackups
   Make filename.ext.CNC.BAK of all modified files.
.PARAMETER OpenURLs
   Opens all URLs in your browser for inspection when finished.
.PARAMETER OpenValidatorInfo
   Opens the Chocolatey package-validator info page on GitHub in your default browser.
.PARAMETER ShowFooter
   Displays $CNCFooter.
.PARAMETER ShowHeader
   Displays $CNCHeader.
.PARAMETER OptimizeImages, -OptimizePNGs
   Runs PNGOptimizerCL on supported image files.
.PARAMETER Recurse
   Runs CNC recursively.
.PARAMETER Update
   Will re-write out your nuspec file; e.g. change to UTF-8 w/o BOM.
.PARAMETER UpdateAll
   Rights all wrongs.
.PARAMETER UpdateImageURLs
   Updates image URLs with Staticaly CDN URLs (default).
.PARAMETER UpdateScripts
   Will re-write out your PowerShell scripts, e.g. change to UTF-8 w/BOM, and add ErrorActionPreference=Stop.
.PARAMETER UpdateXMLComment
   Updates the XML comment for UTF-8 checking.
.PARAMETER UpdateXMLDeclaration
   Updates the XML declaration.
.PARAMETER UpdateXMLNamespace
   Updates the XML Namespace
.PARAMETER UseGitHack
   Use GitHack for image URLs replacement, for use with -UpdateImageURLs or -UpdateAll.
.PARAMETER UseGitCDN
   Use GitCDN for image URLs replacement, for use with -UpdateImageURLs or -UpdateAll.
.PARAMETER UsejsDelivr
   Use jsDeliver for image URLs replacement, for use with -UpdateImageURLs or -UpdateAll.
.PARAMETER WhatIf
   Test run, don't save changes.

.LINK
   https://github.com/chocolatey/package-validator/wiki
.LINK
   https://docs.chocolatey.org/en-us/community-repository/moderation/package-validator/rules/

#>

param (
    [string]$Path=(Get-Location).path,
    [Alias("OptimizePNGs")][switch]$OptimizeImages,
    [Alias("?")][switch]$Help,
    [switch]$AddFooter,
    [switch]$AddHeader,
    [switch]$AddPackageNotes,
    [switch]$Debug,
    [switch]$EditFooter,
    [switch]$EditHeader,
    [switch]$EditPackageNotes,
    [switch]$MakeBackups,
    [switch]$OpenURLs,
    [switch]$OpenValidatorInfo,
    [switch]$Recurse,
    [switch]$ReduceOutput,
    [switch]$ShowFooter,
    [switch]$ShowHeader,
    [switch]$ShowPackageNotes,
    [switch]$Update,
    [switch]$UpdateAll,
    [switch]$UpdateImageURLs,
    [switch]$UpdateScripts,
    [switch]$UpdateXMLComment,
    [switch]$UpdateXMLDeclaration,
    [switch]$UpdateXMLNamespace,
    [switch]$UseGitHack,
    [switch]$UsegitCDN,
    [switch]$UsejsDelivr,
    [switch]$WhatIf
 )

if (!$ReduceOutput) {
    Write-Host "CNC.ps1 v2021.12.20 - (unofficial) Chocolatey .nuspec Checker ""CNC - Run it through the Bill.""" -Foreground White
    Write-Host "Copyleft 2018-2021 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White
}

# Verify ChocolateyToolsLocation was created by Get-ToolsLocation during install and is in the environment
if (!($ENV:ChocolateyToolsLocation)) {$ENV:ChocolateyToolsLocation = "$ENV:SystemDrive\tools"}
if (!(Test-Path "$ENV:ChocolateyToolsLocation\BCURRAN3")) {Write-Warning "Configuration not found. Please re-install.";throw}

# parameters and variables -------------------------------------------------------------------------------------

$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$AcceptableIconExts=@("png","svg")
# All 7Zip supported formats plus EXE, MSU, MSP, APPX, APPXBUNDLE, IMG - What else is needed?
$BinaryExtensions=@("*.exe","*.img","*.msu","*.msp","*.appx","*.appxbundle","*.7z","*.xz","*.bzip2","*.gzip","*.tar","*.zip","*.wim","*.ar","*.arj","*.cab","*.chm","*.cpio","*.cramfs","*.dmg","*.ext","*.fat","*.gpt""*.hfs","*.ihex","*.iso","*.lzh","*.lzma","*.mbr","*.msi","*.nsis","*.ntfs","*.qcow2","*.rar","*.rpm","*.squashfs","*.udf","*.uefi","*.vdi","*.vhd","*.vmdk","*.xar","*.z")
$CDNlist      = "https://www.staticaly.com, https://raw.githack.com, https://gitcdn.link, or https://www.jsdelivr.com"
$CNCHeader    = "$ENV:ChocolateyToolsLocation\BCURRAN3\CNCHeader.txt"
$CNCFooter    = "$ENV:ChocolateyToolsLocation\BCURRAN3\CNCFooter.txt"
$CNCPackageNotes = "$ENV:ChocolateyToolsLocation\BCURRAN3\CNCPackageNotes.txt"
$PNGOptimizer = (Test-Path $ENV:ChocolateyInstall\bin\PngOptimizerCL.exe)
$OptimizeImages=$False
$NewCDN       = "Staticly"
$StaticlyCDN  = $True
$XMLComment = "Do not remove this test for UTF-8: if `“Ω`” doesn`’t appear as greek uppercase omega letter enclosed in quotation marks, you should use an editor that supports UTF-8, not this one."
$XMLNamespace = "http://schemas.microsoft.com/packaging/2015/06/nuspec.xsd"
# <package xmlns="http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd">

if ($help) {
    Get-Help $MyInvocation.MyCommand.Definition -Detailed
	return
}

if (Test-Path $ENV:ChocolateyInstall\bin\notepad++.exe){
     $Editor="notepad++.exe"
    } else {
      $Editor="notepad.exe"
    }

if ($EditFooter) {
    Write-Host "  ** Editing contents of $CNCFooter." -Foreground Magenta
	&$Editor $CNCFooter
	return
}

if ($EditHeader) {
    Write-Host "  ** Editing contents of $CNCHeader." -Foreground Magenta
	&$Editor $CNCHeader
	return
}

if ($EditPackageNotes) {
    Write-Host "  ** Editing contents of $CNCPackageNotes." -Foreground Magenta
	&$Editor $CNCPackageNotes
	return
}

if ($ShowFooter) {
	Write-Host "  ** Displaying contents of $CNCFooter." -Foreground Magenta
    Write-Host	
    Get-Content $CNCFooter
	return
}

if ($ShowHeader) {
    Write-Host "  ** Displaying contents of $CNCHeader." -Foreground Magenta
    Write-Host	
    Get-Content $CNCHeader
	return
}

if ($ShowPackageNotes) {
    Write-Host "  ** Displaying contents of $CNCPackageNotes." -Foreground Magenta
    Write-Host	
    Get-Content $CNCPackageNotes
	return
}

if ($OpenValidatorInfo) {
    Write-Host "  ** Opening https://docs.chocolatey.org/en-us/community-repository/moderation/package-validator/rules/." -Foreground Magenta
    Write-Host	
    &start https://docs.chocolatey.org/en-us/community-repository/moderation/package-validator/rules/
	return
}

if ($Update) {$GLOBAL:UpdateNuspec=$True}

if ($UpdateAll) {
     $UpdateAll=$True
	 $UpdateImageURLs=$True
	 $OptimizeImages=$True
	 $UpdateScripts=$True
	 $UpdateXMLComment=$True
	 $UpdateXMLDeclaration=$True
     $UpdateXMLns=$True
	 $GLOBAL:AddPS1EAP=$True
	 $GLOBAL:UpdateNuspec=$True
   } else {
     $UpdateAll=$False
}

if ($UseGitHack) {
     $GitHackCDN=$True
	 $StaticlyCDN=$False
	 $NewCDN="GitHack"
   } else {
     $GitHackCDN=$False
}

if ($UsegitCDN) {
     $GitCDN=$True
	 $StaticlyCDN=$False
	 $NewCDN="GitCDN"
   } else {
     $GitCDN=$False
}

if ($UsejsDelivr) {
     $jsDelivrCDN=$True
	 $StaticlyCDN=$False
	 $NewCDN="jsDelivr"
   } else {
     $jsDelivrCDN=$False
}

if ($path -eq "\"){
    $path=(Get-Location).Drive.Name + ":" + "\"
}

if (!(Test-Path $path)){
    Write-Host "           ** $path is an invalid path." -Foreground Red
	return
   }
   
## Import preferences - see comments in CNC.config for settings 
#[xml]$ConfigFile = Get-Content "$scriptDir\CNC.config"
#$UpdateAll       = $ConfigFile.Settings.Preferences.UpdateAll
#$CDN             = $ConfigFile.Settings.Preferences.CDN
#$MakeBackups     = $ConfigFile.Settings.Preferences.MakeBackups
#$OptimizeImages  = $ConfigFile.Settings.Preferences.OptimizeImages
#$Header          = $ConfigFile.Settings.Preferences.Header
#$Footer          = $ConfigFile.Settings.Preferences.Footer
#$PackageNotes    = $ConfigFile.Settings.Preferences.PackageNotes

#$UseHeader       = $ConfigFile.Settings.Preferences.UseHeader
#$UseFooter       = $ConfigFile.Settings.Preferences.UseFooter
#$UsePackageNotes = $ConfigFile.Settings.Preferences.UsePackageNotes
   
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
if ($NuspecIconURL -Match '.SVG') {
	Write-Host "           ** <iconUrl> - SVG image found. It's a vector Victor, there are no dimensions! Roger, over!" -Foreground Green
	return
	}
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
        if (!$ReduceOutput) {
	      Write-Host "           ** Suggestion: Use package icons with at least 128 pixels in width or height if available." -Foreground Cyan
		}
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
		  if ($element -notmatch ".PS1"){  	      
		      Write-Host "WARNING:   ** $element - the URL:`n              $url`n              is probably bad, status code: $HTTP_Status. This will trigger a message from the verifier:" -Foreground Red
	          Write-Host "           ** Requirement: The $element element in the nuspec file should be a valid Url. Please correct this" -Foreground Cyan
		      Write-Host "           ** Suggestion: Consider using CNC's -OpenURLs option to open and view all URLs in the .nuspec." -Foreground Cyan
	          $GLOBAL:Required++
		  } else {
		    Write-Warning ("  ** $element - the URL:`n              $url`n              site might be OK, status code: $HTTP_Status.")
		    Write-Host "           ** Suggestion: Check your download link, it appears to be bad." -Foreground Cyan
		    $GLOBAL:Suggestions++
		    }
		  $GLOBAL:ValidURL=$False
        }
   }
}

# Check for license files when binaries are included
function Check-LicenseFile{
  $LicenseFile=(Get-ChildItem -Path $path -Include *LICENSE* -Recurse)
  if ($LicenseFile){
      if (!$ReduceOutput) {
	    Write-Host 'FYI:       ** Binary files - '$LicenseFile.Name'file(s) found.' -Foreground Green          
      }
	  $GLOBAL:FYIs++
	 } else {
	   Write-Host "WARNING:   ** Binary files - LICENSE.txt file NOT found. This will trigger a message from the verifier:" -Foreground Red
	   Write-Host "           ** Requirements: Binary files (.exe, .msi, .zip, etc) have been included without including a LICENSE.txt`n              file. This file is required when including binaries " -Foreground Cyan
	   $GLOBAL:Required++
      }
}

# Check for verification file when binaries are included
function Check-VerificationFile{
  $VerificationFile=(Get-ChildItem -Path $path -Include *VERIFICATION* -Recurse)
  if ($VerificationFile){
      if (!$ReduceOutput) {
        Write-Host 'FYI:       ** Binary files - '$VerificationFile.Name'file(s) found.' -Foreground Green
	  }
      $GLOBAL:FYIs++
	} else {
	  Write-Host "WARNING:   ** Binary files - VERIFICATION.txt file NOT found. This will trigger a message from the verifier:" -Foreground Red
	  Write-Host "           ** Requirements: Binary files (.exe, .msi, .zip) have been included without including a VERIFICATION.txt`n              file. This file is required when including binaries" -Foreground Cyan
	  $GLOBAL:Required++
    }
}

# check for binaries
function Check-Binaries{
  $IncludedBinaries=(Get-ChildItem -Path $path -Include $BinaryExtensions -Recurse)
  if ($IncludedBinaries){
      Write-Warning "  ** Binary files found in package. This will trigger a message from the verifier:"
      if (!$ReduceOutput) {
        Write-Host "           ** Note: Binary files (.exe, .msi, .zip) have been included. The reviewer will ensure the maintainers have`n              distribution rights." -Foreground Cyan
	  }
      $GLOBAL:Notes++
	  Check-LicenseFile
	  Check-VerificationFile
     }
}

# check for OS index files that should be excluded
function Check-OSIndexFiles{
  $NotWanted=(Get-ChildItem -Path $path -Include "*.ds_store","thumbs.db" -Recurse)
  if ($NotWanted){
      Write-Host "WARNING:   ** Operating System index files found in directory. If found in the package, this will trigger a message`n              from the verifier:" -Foreground Red
      Write-Host "           ** Required: The package contains Operating System index files, .ds_store or thumbs.db. Please remove all`n              index files from the package. " -Foreground Cyan
	   $GLOBAL:Required++
     }
}


# check for PNG files for possible optimization
function Check-PNGs{
  $ImageFiles=(Get-ChildItem -Path $path -Include *.PNG,*.BMP,*.GIF,*.TGA -Recurse)
  if ($ImageFiles){
      Write-Host 'FYI:       ** Binary files - PNG, BMP, GIF, or TGA image file(s) found.' -Foreground Yellow
	  $GLOBAL:FYIs++
	  if (!$OptimizeImages){
	  Write-Host '           ** Suggestion: Consider running CNC -OptimizeImages to optimize your image file(s).' -Foreground Cyan
	  $GLOBAL:Suggestions++
	 }
    }
}

# I'm making an educated guess that these are requirements to be fixed, not verified.
function Check-PackageInternalFilesIncluded{
  if (Test-Path '`[Content_Types`].xml') {
      Write-Host "WARNING:   ** [Content_Types].xml file found. This will trigger a message from the verifier:" -Foreground Red
	  Write-Host "           ** Required: You have repackaged an existing package that you unpacked without removing some of the `n              packaging files from the original."  -Foreground Cyan
	   $GLOBAL:Required++
     }
  if (Test-Path *.psmd) {
      Write-Host "WARNING:   ** PSMD file(s) found. This will trigger a message from the verifier:" -Foreground Red
	  Write-Host "           ** Required: You have repackaged an existing package that you unpacked without removing some of the `n              packaging files from the original."  -Foreground Cyan
	   $GLOBAL:Required++
     }
  if (Test-Path *.rels) {
      Write-Host "WARNING:   ** RELS file(s) found. This will trigger a message from the verifier:" -Foreground Red
	  Write-Host "           ** Required: You have repackaged an existing package that you unpacked without removing some of the `n              packaging files from the original."  -Foreground Cyan
	   $GLOBAL:Required++
     }
  if (Test-Path _rels) {
      Write-Host "WARNING:   ** _RELS directory found. This will trigger a message from the verifier:" -Foreground Red
	  Write-Host "           ** Required: You have repackaged an existing package that you unpacked without removing some of the `n              packaging files from the original."  -Foreground Cyan
	   $GLOBAL:Required++
     }
}

# check if header template is in the description
function Check-Header{
  $NuspecDescription=$NuspecDescription.Trim()
  if ($NuspecDescription.StartsWith("***") -or $NuspecDescription.StartsWith("---") -or $NuspecDescription.StartsWith("___")){ 
      Write-Host "FYI:       ** <description> - header template found." -Foreground Green
	  $GLOBAL:FYIs++
	  $GLOBAL:FoundHeader=$True
     } else {
       $GLOBAL:FoundHeader=$False
       $GLOBAL:Suggestions++
       if (!($AddPackageNotes) -and !($ReduceOutput)) {	 
	       Write-Host '           ** Suggestion: Consider adding a header and help propagate (unofficial) choco:// Protocol support' -Foreground Cyan
	      }
	   }
}

# add header template to <description>
function Add-Header{
  if ($GLOBAL:FoundHeader){
      Write-Host "FYI:       ** <description> - header template previously added." -Foreground Cyan
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

# check if footer template is in the description
function Check-Footer{
  $NuspecDescription=$NuspecDescription.Trim()
  if ($NuspecDescription.EndsWith("***") -or $NuspecDescription.EndsWith("---") -or $NuspecDescription.EndsWith("___")){
      Write-Host "FYI:       ** <description> - footer template found." -Foreground Green
	  $GLOBAL:FYIs++
	  $GLOBAL:FoundFooter=$True
     } else {
       $GLOBAL:FoundFooter=$False
	  }
}

# add footer template to <description>
function Add-Footer{
  if ($GLOBAL:FoundFooter){
      Write-Host "FYI:       ** <description> - footer template previously added." -Foreground Cyan
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

# TDL - check only head and tail of the description; maybe 5 lines
# check if package release notes are in the description
function Check-PackageNotes{
  $NuspecDescription=$NuspecDescription.Trim()
  if (($NuspecDescription -match 'PACKAGE NOTES') -or ($NuspecDescription -match 'PACKAGE RELEASE NOTES')){
      Write-Host "FYI:       ** <description> - package release notes found." -Foreground Green
	  $GLOBAL:FYIs++
	  $GLOBAL:FoundPackageNotes=$True
     } else {
       $GLOBAL:FoundPackageNotes=$False
       $GLOBAL:Suggestions++
       if (!($AddPackageNotes) -and (!$ReduceOutput) ) {
	       Write-Host '           ** Suggestion: Consider adding PACKAGE NOTES to inform users of any special information about the package.' -Foreground Cyan
	      }
	  }
}

# add package notes template to <description>
function Add-PackageNotes{
  if ($GLOBAL:FoundPackageNotes){
      Write-Host "FYI:       ** <description> - package notes template previously added." -Foreground Cyan
	  $GLOBAL:FYIs++
	  return $NuspecDescription
	 }	
  if (Test-Path $CNCPackageNotes){
      $PackageNotes=[IO.File]::ReadAllText($CNCPackageNotes)
	  if ($PackageNotes -match '\$NuspecAuthors') {$PackageNotes=PackageNotes -replace '\$NuspecAuthors',"$NuspecAuthors"}
	  if ($PackageNotes -match '\$NuspecID') {$PackageNotes=$PackageNotes -replace '\$NuspecID',"$NuspecID"}
	  if ($PackageNotes -match '\$NuspecOwners') {$PackageNotes=$PackageNotes -replace '\$NuspecOwners',"$NuspecOwners"}
	  if ($PackageNotes -match '\$NuspecTitle') {$PackageNotes=$PackageNotes -replace '\$NuspecTitle',"$NuspecTitle"}
      if ($PackageNotes -match '\$NuspecVersion') {$PackageNotes=$PackageNotes -replace '\$NuspecVersion',"$NuspecVersion"}
      $NuspecDescription=$NuspecDescription + "`n" + $PackageNotes + "`n"
      Write-Host "           ** <description> - ADDED package notes template." -Foreground Green
      $GLOBAL:UpdateNuspec=$True
	  $GLOBAL:Fixes++
	  return $NuspecDescription
    } else {
	  Write-Warning "           ** $CNCPackageNotes NOT found."
	  return $NuspecDescription
    }
}

# check Markdown header problems after chocolatey.org Sept. 2019 updates
function Check-Markdown([string]$element,[string]$text){
  if ($NuspecDescription -match "#\w") { # alphanumeric whitespace only (no /, [, etc)
      Write-Host "WARNING:   ** $element - invalid Markdown heading syntax found. This will trigger a message from the verifier:" -Foreground Red
	  Write-Host "           ** Required: Package Description should not contain invalid Markdown Headings."  -Foreground Cyan
      $GLOBAL:Required++
	  }
}

# TDL
# Add whitespace after #, ##, and ### when found followed by characters
function Fix-Markdown{
}

# Check package current status on chocolatey.org
function Check-OnlineStatus{
$PackagePageInfo  = try { (Invoke-WebRequest -Uri "https://chocolatey.org/packages/$NuspecID" -UseBasicParsing -DisableKeepAlive).StatusCode } catch [Net.WebException]{ [int]$_.Exception.Response.StatusCode } 
  if ($PackagePageInfo -eq '404'){
	  Write-Host "FYI:       ** This appears to be a brand new package. Cool!" -Foreground Green
	  $GLOBAL:FYIs++
	  return
	 } 
   $PackagePageInfo = (Invoke-WebRequest -DisableKeepAlive -Uri "https://chocolatey.org/packages/$NuspecID")
   if ($PackagePageInfo -match "This package was approved as <a href=""https://chocolatey.org/faq#what-is-a-trusted-package"">a trusted package"){
	   if (!$ReduceOutput) {
         Write-Host "FYI:       ** $NuspecID is a trusted package. (Congrats!)" -Foreground Green
	   }
       $GLOBAL:FYIs++
	  }
   if ($PackagePageInfo -match 'All Checks are Passing'){
	   if (!$ReduceOutput) {
         Write-Host "FYI:       ** $NuspecID current status: All Checks are Passing" -Foreground Green
       }
	   $GLOBAL:FYIs++
	  }
   if (($NuspecID -ne 'choco-nuspec-checker') -and ($PackagePageInfo -match '
Some Checks Have Failed or Are Not Yet Complete')){
	   Write-Host "FYI:       ** $NuspecID current status: 
Some Checks Have Failed or Are Not Yet Complete" -Foreground Red
	   $GLOBAL:FYIs++
	  }
   if ($PackagePageInfo -match 'There are versions of this package awaiting moderation'){
	   Write-Host "FYI:       ** $NuspecID may have submitted/unapproved versions pending moderation." -Foreground Yellow
	   $GLOBAL:FYIs++
	  }
   if ($PackagePageInfo -match 'Waiting for Maintainer'){
	   Write-Host "FYI:       ** $NuspecID may have a version waiting for corrective action." -Foreground Yellow
	   $GLOBAL:FYIs++
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

# Run PNGOptimizerCL on supported image files
function Run-PNGOptimizer{
  if ($OptimizeImages){
  if (!$PNGOptimizer){
      Write-Warning "  ** -OptimizeImages parameter given but PNGOptimizerCL.exe not found."
	  Write-Host "           ** Run choco install pngoptimizer.commandline first to use this feature." -Foreground Cyan
	  return
     }
  $ImageFiles=(Get-ChildItem -Path $path -Include *.PNG,*.BMP,*.GIF,*.TGA -Recurse)
  if ($ImageFiles -and $PNGOptimizer){
      Write-Host "           ** Running PNGOptimzerCL on supported image files." -Foreground Green
	  if ($WhatIf){
          Write-Host "CNC did NOT optimize your image files, -WhatIf parameter was used." -Foreground Magenta
	    } else {
          if ($MakeBackups){
              &pngoptimizercl.exe -file:""$path/"" -recurs -BackupOldPngFiles
		  } else {
            &pngoptimizercl.exe -file:""$path/"" -recurs
		  }
		  $GLOBAL:Fixes++
		 }
  }
 }
}

# TODO check for "main" when GH stops making new repos with "master" in 10/2020
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
  if ($scriptFile -match "UPDATE.PS1") {return}
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
  if ($scriptFile -match "UPDATE.PS1") {return}
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
  if ($scriptFile -match "UPDATE.PS1") {return}
  if ($UpdateScripts -and !$WhatIf){
      if ($MakeBackups){Copy-Item "$ScriptFile" "$ScriptFile.CNC.bak" -Force}
#	  Write-Host "           ** $ScriptFile - will be converted to UTF-8 w/ BOM and saved." -Foreground Green
      $Body=Get-Content $ScriptFile
      Write-Output $Body | Out-File $ScriptFile
	  $GLOBAL:Fixes++
	  }
}

# Check chocolateyInstall.ps1 for SourceForge download links
function Check-DiscouragedDownloadLinks{
if (Test-Path $path\tools\chocolateyInstall.ps1){
   $test=Get-Content $path\tools\chocolateyInstall.ps1
    if ($test -match "sourceforge"){
        Write-Warning "  ** CHOCOLATEYINSTALL.PS1 uses SourceForge as download source. This will trigger a message from the verifier:"
	    if (!$ReduceOutput) {
          Write-Host "           ** Guideline: Using SourceForge as the download source of installers is not recommended. Please consider an`n              alternative, official distribution location if one is available." -Foreground Cyan
	    }
        $GLOBAL:Guidelines++
       }
    if ($test -match "fosshub"){
        Write-Warning "  ** CHOCOLATEYINSTALL.PS1 uses FossHub as download source."
	    if (!$ReduceOutput) {
          Write-Host "           ** Guideline: In Dec. 2016 FossHub requested ""Please help us keep our costs down by not using scripts`n              to download software from our site.""" -Foreground Cyan
	    }
        $GLOBAL:Guidelines++
       }
  }
}

function Check-ScriptNames{
$ChocoInstallScript=Get-ChildItem "$path\chocolateyinstall.ps1" -Recurse
$NugetInstallScript=Get-ChildItem "$path\install.ps1" -Recurse
if (!$ChocoInstallScript -and $NugetInstallScript){
     Write-Host "WARNING:   ** Install Script Named Incorrectly." -Foreground Red
	 Write-Host "           ** Your script is named incorrectly and will need to be renamed. A script named chocolateyInstall.ps1 was`n              not found in your package, but another script ending in install.ps1 was found. The install script should`n              be named chocolateyInstall.ps1 and be found in the tools folder." -Foreground Cyan
	 $GLOBAL:Required++
   }

}

# borrowed from https://www.jonathanmedd.net/2012/05/quick-and-easy-powershell-test-xmlfile.html
function Test-XMLFile {
    <#
        .SYNOPSIS
        Test the validity of an XML file
    #>
    [CmdletBinding()]
    param (
        [parameter(mandatory=$true)][ValidateNotNullorEmpty()][string]$xmlFilePath
    )

    # Check the file exists
    if (!(Test-Path -Path $xmlFilePath)){
        throw "$xmlFilePath is not valid. Please provide a valid path to the .xml fileh"
    }
    # Check for Load or Parse errors when loading the XML file
    $xml = New-Object System.Xml.XmlDocument
    try {
        $xml.Load((Get-ChildItem -Path $xmlFilePath).FullName)
        return $true
    }
    catch [System.Xml.XmlException] {
        Write-Verbose "$xmlFilePath : $($_.toString())"
        return $false
    }
}

# Update the nuspec XML namespace declaration
# Only checks for the common 2011/08/nuspec.xsd namespace, could be much better using regex.
# Messages related to this happening or not (-WhatIf) are difficult to implement because this change happens independly of other changes to the .nuspec, notifications need to be implemented in most cases.
function Update-XMLnsDeclaration{
  if ($MakeBackups){Copy-Item "$LocalnuspecFile" "$LocalnuspecFile.CNC.XMLnamespace.bak" -Force}
  ((Get-Content -Path $LocalnuspecFile -Raw) -Replace 'http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd','http://schemas.microsoft.com/packaging/2015/06/nuspec.xsd') | Set-Content -Path $LocalnuspecFile
  $GLOBAL:DelayedUpdateXMLnsDeclarationMessage=$True
  $GLOBAL:Fixes++
}

#Start running the actual script --------------------------------------------------------------------------------------------

if ($recurse) {
	$folderlist = Split-Path (Get-ChildItem -Path $path -Recurse -Filter "*.nuspec").fullname
    } else {
	  $folderlist = $path
}

ForEach ($path in $folderlist) {
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

if (!(Test-XMLFile $LocalnuspecFile)){
    Write-Warning "  ** $LocalnuspecFile is not a valid XML file."
    Write-Host "FYI:     ** Common problems:" -Foreground Cyan
    Write-Host "            choco pack will report: ""An error occurred while parsing EntityName."" for unexpected/malformed ""&""'s." -Foreground Cyan
    Write-Host "            choco pack will report: ""'<' is an unexpected token. The expected token is '>'."" for bad/unclosed elements." -Foreground Cyan
    Write-Host "            choco pack will report: ""The <tag> start tag on line x position x does not match the end tag of <tag>`n.                                    Line x, position x."" for elements with mismatched case.`n" -Foreground Cyan
    break
}

if ($UpdateXMLns){
    if ($WhatIf){
		$GLOBAL:DelayedUpdateXMLnsDeclarationMessage=$False
       } else {
         Update-XMLnsDeclaration
        }
}

# variables for end results
$GLOBAL:Required=0
$GLOBAL:Guidelines=0
$GLOBAL:Suggestions=0
$GLOBAL:Notes=0
$GLOBAL:Fixes=0
$GLOBAL:FYIs=0
$GLOBAL:UpdateNuspec=$False
$GLOBAL:TemplateError=0
$GLOBAL:DelayedUpdateXMLnsDeclarationMessage=$False

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


# Start outputting check results
Write-Host "CNC Summary of $NuspecDisplayName (v$NuspecVersion):" -Foreground Magenta

# Open all .nuspec URLs for viewing if -OpenURLs is passed
if ($OpenURLs) {
    Write-Host "           ** Opening all .nuspec URLs in your default browser for viewing." -Foreground Magenta
	Open-URLs
	}
	
# checks ------------------------------------------------------------------------------------------------

# Trusted package check
Check-OnlineStatus

if (Test-Path 'update.ps1') {
    Write-Host "FYI:       ** UPDATE.PS1 found. You must be smarter than the average bear..." -Foreground Green
	$GLOBAL:FYIs++
	}

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
		   Write-Host "           ** Suggestion: Consider running CNC -Update to re-write`n              $NuspecDisplayName to UTF-8 w/o BOM." -Foreground Cyan
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
	  if ($nuspecFile.'#comment' -match 'Read this before creating packages'){
          Write-Host "WARNING:   ** XML comment contains templated values. This will trigger a message from the verifier:" -Foreground Red
          Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
          $GLOBAL:Required++
	  }
	 }
}

# check XML Namespace
if ($NuspecXMLNamespace -ne "$XMLNamespace"){
    Write-Warning "  ** XML namespace declaration is $NuspecXMLNamespace"
    Write-Host "           ** The current schema is $XMLNamespace" -Foreground Cyan
    Write-Host "           ** Suggestion: Consider running CNC -UpdateXMLNamespace to update the XML namespace declaration." -Foreground Cyan
	$GLOBAL:Suggestions++
}

if ($GLOBAL:DelayedUpdateXMLnsDeclarationMessage) {Write-Host "           ** XML namespace declaration changed to http://schemas.microsoft.com/packaging/2015/06/nuspec.xsd" -Foreground Green}

# <authors> checks
if (!($NuspecAuthors)) {
    Write-Host "WARNING:   ** <authors> element is empty, this element is a requirement." -Foreground Red
	$GLOBAL:Required++
   } else {
     if ($NuspecAuthors -match "@"){
	     Write-Host "WARNING:   ** <authors> - contains an e-mail address. This will trigger a message from the verifier:" -Foreground Red
	     Write-Host '           ** Requirements: Email address should not be used in the Author and Copyright fields of the nuspec file. ' -Foreground Cyan
		 $GLOBAL:Required++
	    }
	 if ($NuspecAuthors -cmatch '__REPLACE_AUTHORS_OF_SOFTWARE_COMMA_SEPARATED__'){
         Write-Host "WARNING:   ** <authors> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
		}
   }

# <bugTrackerUrl> checks
if (!($NuspecBugTrackerURL)) {
     Write-Warning "  ** <bugTrackerUrl> - element is empty. This will trigger a message from the verifier:"
	if (!$ReduceOutput) {
      Write-Host '           ** Suggestion: bugTrackerUrl - points to the location where issues and tickets can be accessed' -Foreground Cyan
	}
    $GLOBAL:Suggestions++
   } else {
     Validate-URL "<bugTrackerUrl>" $NuspecBugTrackerURL
	}

# <conflicts> checks - Built for the future
#if (!($NuspecConflicts)) {Write-Warning "  ** <conflicts> element is empty."}

# <copyright> checks
if (!($NuspecCopyright)) {
    Write-Host "FYI:       ** <copyright> - element is empty." -Foreground Yellow
	$GLOBAL:FYIs++
	} else {
	  if ($NuspecCopyright.Length -lt 5) {
	      Write-Host "WARNING:   ** <copyright> - is less than 5 characters. This will trigger a message from the verifier:" -Foreground Red
		  Write-Host '           ** Requirements: If you are going to use copyright in the nuspec, please use more than 4 characters.' -Foreground Cyan
		  $GLOBAL:Required++
		  }
	  if ($NuspecAuthors -match "@"){
	      Write-Host "WARNING:   ** <copyright> - contains an e-mail address. This will trigger a message from the verifier:" -Foreground Red
	      Write-Host '           ** Requirements: Email address should not be used in the Author and Copyright fields of the nuspec file. ' -Foreground Cyan
          $GLOBAL:Required++
	 }
	 if ($NuspecCopyright -eq 'Year Software Vendor'){
         Write-Host "WARNING:   ** <copyright> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
	    }
	}

# <dependencies> checks
if (!($NuspecDependencies)) {
    if (!$ReduceOutput) {
      Write-Host "FYI:       ** <dependencies> - element is empty." -Foreground Yellow
	}
    $GLOBAL:FYIs++
   } else {
     if ((!$NuspecDependencies) -and ($NuspecTitle -match "deprecated")){
	      Write-Host "WARNING:   ** <dependencies> - Deprecated packages must have a dependency." -Foreground Red
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
      	      if (!$ReduceOutput) {
                Write-Host "           ** Guideline: Package contains dependencies with no specified version. You should at least specify`n              a minimum version of a dependency." -Foreground Cyan
			  }
              $GLOBAL:Guidelines++
	         }
	 } else {
	   $DependencyNumber=0
	 do{
	    $DependencyName=$NuspecDependencies.dependency.id[$DependencyNumber]
 	    if ($NuspecDependencies.dependency[$DependencyNumber].version -eq $null){
				Write-Warning "  ** <dependencies> - ""$DependencyName"" has no version. This will trigger a message from the verifier:"
			    if (!$ReduceOutput) {
                  Write-Host "           ** Guideline: Package contains dependencies with no specified version. You should at least specify`n              a minimum version of a dependency." -Foreground Cyan
				}
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
    Write-Host "WARNING:   ** <description> - element is empty, this element is a requirement." -Foreground Red
	$GLOBAL:Required++
   } else {
     Check-Header
	 if ($AddHeader) {
         $NuspecDescription=(Add-Header)
        }
     Check-PackageNotes
	 if ($AddPackageNotes) {
         $NuspecDescription=(Add-PackageNotes)
        }
     Check-Footer
	 if ($AddFooter) {
         $NuspecDescription=(Add-Footer)
        }
     Check-Markdown "<description>" $NuspecDescription
     if ($NuspecDescription.Length -lt 30) {
	     Write-Warning "  ** <description> - is less than 30 characters." 
		 if (!$ReduceOutput) {
           Write-Host "           ** Guideline: Description should be sufficient to explain the software. Please fill in the description`n              with more information about the software. Feel free to use use markdown." -Foreground Cyan
		 }
         $GLOBAL:Guidelines++
		 }
     if ($NuspecDescription.Length -gt 4000) {
		 $TotalChars=$NuspecDescription.Length
	     Write-Host "WARNING:   ** <description> - is $TotalChars characters. Pushing the package will generate the error:" -Foreground Red
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
	  if ($NuspecDescription -cmatch '__REPLACE__MarkDown_Okay'){
          Write-Host "WARNING:   ** <description> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
          Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
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
	if (!$ReduceOutput) {
      Write-Host '           ** Suggestion: docsUrl - points to the location of the wiki or docs of the software' -Foreground Cyan
	}
    $GLOBAL:Suggestions++
   } else {
     if ($NuspecDocsURL -match 'At what url are the software docs located'){
	     Write-Host "WARNING:   ** <docsUrl> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
		} else {
		  Validate-URL "<docsUrl>" $NuspecDocsURL
		 }
}

# <files> checks
if (!($NuspecFiles)) {
    Write-Host 'FYI:       ** <files> - element is empty or missing. If missing, all of the following files will be packaged:' -Foreground Yellow
    Get-ChildItem -Path $path -Recurse -Exclude *.nupkg,tools |% $_.file {Write-Host "           ** $_" -Foreground Cyan -ea SilentlyContinue}
    Write-Host '           ** <files> - It is best practice to add:' -Foreground Yellow
    Write-Host '                        <files>' -Foreground Yellow
    Write-Host '                          <file src="tools\**" target="tools" />' -Foreground Yellow
    Write-Host '                        <files>' -Foreground Yellow
	$GLOBAL:FYIs++
}

# <iconUrl> checks
if (!($NuspecIconURL)) {
    Write-Warning "  ** <iconUrl> - element is empty. This will trigger a message from the verifier:"
	if (!$ReduceOutput) {
      Write-Host '           ** Guideline: The iconUrl should be added if there is one. Please correct this in the nuspec, if applicable.' -Foreground Cyan
    }
	$GLOBAL:Guidelines++
   } else {
     if ($NuspecIconURL -cmatch 'REPLACE_YOUR_REPO'){
	     Write-Host "WARNING:   ** <iconUrl> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
		}
     Validate-URL "<iconUrl>" $NuspecIconURL
	 if ($GLOBAL:ValidURL){
	     Get-ImageDimensions
	    }
	 $IconExt=($NuspecIconURL | Select-String -Pattern $AcceptableIconExts)
     if (!($IconExt)){
	     Write-Warning "  ** <iconUrl> - Your package icon is NOT a .PNG or .SVG. This will trigger a message from the verifier:"
	     if (!$ReduceOutput) {
           Write-Host '           ** Suggestion: As per the packaging guidelines icons should be either a png or svg file.' -Foreground Cyan
	     }
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
    Write-Host "WARNING:   ** <id> - element is empty, this element is a requirement." -Foreground Red
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
	      Write-Host "WARNING:   ** <id> - includes a '.config'. This is not allowed." -Foreground Red
		  $GLOBAL:Required++
		 }
}

# <licenseUrl> checks
if (!($NuspecLicenseURL)) {
    Write-Warning "  ** <licenseUrl> - element is empty. This will trigger a message from the verifier:"
	if (!$ReduceOutput) {
      Write-Host "           ** Guideline: The licenseUrl should be added if there is one. Please correct this in the nuspec,`n              if applicable." -Foreground Cyan
	}
    $GLOBAL:Guidelines++
   } else {
     if ($NuspecLicenseURL -eq $NuspecprojectUrl) {
         Write-Warning "  ** <licenseUrl> - is the same as <projectUrl>. This will trigger a message from the verifier:"
	     if (!$ReduceOutput) {
           Write-Host "           ** Guideline: The licenseUrl should not usually be an exact match to softwareUrl. Please correct this in the`n              nuspec, if applicable. ." -Foreground Cyan
	     }
         $GLOBAL:Guidelines++
		}
     if ($NuspecLicenseURL -cmatch 'REMOVE_OR_FILL_OUT'){
         Write-Host "WARNING:   ** <licenseUrl> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
		} else {
          Validate-URL "<licenseUrl>" $NuspecLicenseURL
		 }
}	

# <mailingListUrl> checks
if (!($NuspecMailingListURL)) {
    Write-Warning "  ** <mailingListUrl> - element is empty. This will trigger a message from the verifier:"
	if (!$ReduceOutput) {
      Write-Host '           ** Suggestion: mailingListUrl - points to the forum or email list group for the software' -Foreground Cyan
	}
    $GLOBAL:Suggestions++
   } else {
     Validate-URL "<mailingListUrl>" $NuspecMailingListURL
	}
	
# <owners> checks
if (!($NuspecOwners)) {
    Write-Host "WARNING:   ** <owners> element is empty, this element is a requirement." -Foreground Red
	$GLOBAL:Required++
   } else {
     if ($NuspecOwners -cmatch 'REPLACE_YOUR_NAME'){
         Write-Host "WARNING:   ** <owners> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
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
	if (!$ReduceOutput) {
      Write-Host "           ** Guideline: The nuspec has been enhanced to allow packageSourceUrl, pointing to the url where the package`n              source resides. This is a strong guideline because it simplifies collaboration.`n              Please add it to the nuspec." -Foreground Cyan
	}
    $GLOBAL:Guidelines++
   } else {
     if ($NuspecPackageSourceURL -cmatch 'Where is this Chocolatey package located'){
	     Write-Host "WARNING:   ** <packageSourceUrl> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
		} else {
          Validate-URL "<packageSourceUrl>" $NuspecPackageSourceURL
		 }
	}

# <projectSourceUrl> checks
if (!$NuspecProjectSourceURL) {
    Write-Warning "  ** <projectSourceUrl> - element is empty. This will trigger a message from the verifier:"
	if (!$ReduceOutput) {
      Write-Host '           ** Suggestion: projectSourceUrl - points to the location of the underlying software source' -Foreground Cyan
	}
    $GLOBAL:Suggestions++
   } else {
     if ($NuspecProjectSourceURL -match 'Software Source Location'){
         Write-Host "WARNING:   ** <projectSourceUrl> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
		} else {
          Validate-URL "<projectSourceUrl>" $NuspecProjectSourceURL
		 }
	 if ($NuspecProjectURL -eq $NuspecProjectSourceURL){
         Write-Warning "  ** <projectUrl> and <projectSourceUrl> elements are the same. This will trigger a message from the verifier:"
         if (!$ReduceOutput) {
           Write-Host "           ** Guideline: ProjectUrl and ProjectSourceUrl are typically different, but not always. Please ensure`n              that projectSourceUrl is pointing to software source code or remove the field from the nuspec." -Foreground Cyan
		 }
         $GLOBAL:Guidelines++
       }
	}
	
# <projectUrl> checks
if (!($NuspecProjectURL)) {
    Write-Host "WARNING:   ** <projectUrl> - element is empty. This will trigger a message from the verifier:" -Foreground Red
    Write-Host "           ** Requirement: ProjectUrl (projectUrl) in the nuspec file is required. Please add it to the nuspec." -Foreground Cyan
	$GLOBAL:Required++
   } else {
     if ($NuspecProjectURL -cmatch 'REMOVE_OR_FILL_OUT'){
         Write-Host "WARNING:   ** <projectUrl> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
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
	if (!$ReduceOutput) {
      Write-Host "           ** Guideline: Release Notes (releaseNotes) are a short description of changes in each version of a package.`n              Please include releasenotes in the nuspec. NOTE: To prevent the need to continually update this field,`n              providing a URL to an external list of Release Notes is perfectly acceptable." -Foreground Cyan
	}
    $GLOBAL:Guidelines++
   } else {
     Check-Markdown "<releaseNotes>" $NuspecReleaseNotes
     if ($NuspecReleaseNotes -cmatch 'REPLACE_OR_REMOVE'){
         Write-Host "WARNING:   ** <releaseNotes> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
         Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
         $GLOBAL:Required++
	    }
	 }

# <replaces> checks - Built for the future
#if (!($NuspecReplaces)) {Write-Warning "  ** <replaces> element is empty."}

# <requireLicenseAcceptance> checks
if (!($NuspecRequireLicenseAcceptance)) {
    Write-Host "FYI:       ** <requireLicenseAcceptance> - element is empty." -Foreground Yellow
	$GLOBAL:FYIs++
	} else {
	  if (($NuspecRequireLicenseAcceptance -eq "true") -and (!($NuspecLicenseURL))) {
	      Write-Host "WARNING:   ** <requireLicenseAcceptance> is set to true but <licenseUrl> is empty." -Foreground Red
		  $GLOBAL:Required++
		  }
	  }

# <summary> checks
if (!($NuspecSummary)) {
    Write-Warning "  ** <summary> - element is empty. This will trigger a message from the verifier:"
    if (!$ReduceOutput) {
      Write-Host '           ** Guideline: Summary (summary) is a short explanation of the software. Please include summary in the nuspec.' -Foreground Cyan
	}
    $GLOBAL:Guidelines++
	} else {
	  if ($NuspecSummary -cmatch '__REPLACE__'){
          Write-Host "WARNING:   ** <summary> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
          Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
          $GLOBAL:Required++
		 }
     }

# <tags> checks
if (!($NuspecTags)) {
     Write-Host "WARNING:   ** <tags> - element is empty." -Foreground Red
	 $GLOBAL:Required++
	} else {
	  if ($NuspecTags -match ","){
         Write-Host "WARNING:   ** <tags> - tags are separated with commas. They should only be separated with spaces." -Foreground Red
		 $GLOBAL:Required++
		}
	  if ($NuspecTags -match "admin"){
         Write-Host "FYI:       ** <tags> - there is a tag named ""admin"" which is now deemed unnecessary." -Foreground Yellow
         Write-Host '           ** The majority of Chocolatey packages require admin rights to install, this is considered default behavior.' -Foreground Cyan
		 $GLOBAL:FYIs++
		}	
	  if ($NuspecTags -match "chocolatey"){
         Write-Warning "  ** <tags> - there is a tag named ""chocolatey"" which will trigger a message from the verifier:"
         if (!$ReduceOutput) {
           Write-Host '           ** Guideline: Tags (tags) should not contain 'chocolatey' as a tag. Please remove that in the nuspec.' -Foreground Cyan
		 }
         $GLOBAL:Guidelines++
		}
	  if ($NuspecTags -match "notsilent"){
         Write-Warning "  ** <tags> - there is a tag named ""notsilent"" which will trigger a message from the verifier:"
         Write-Host '           ** Note: notSilent tag is being used. The reviewer will ensure this is being used appropriately. ' -Foreground Cyan
		 $GLOBAL:Notes++
		}
	  if ($NuspecTags -cmatch 'SPACE_SEPARATED'){
          Write-Host "WARNING:   ** <tags> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
          Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
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
		 if (!$ReduceOutput) {
           Write-Host "           ** Guideline: Title (title) matches id exactly. Please consider using something slightly more descriptive`n              for the title in the nuspec." -Foreground Cyan
		 }
         $GLOBAL:Guidelines++
	   }
   }

# <version> checks
if (!($NuspecVersion)) {
    Write-Host "WARNING:   ** <version> - element is empty, this element is a requirement." -Foreground Red
	$GLOBAL:Required++
	} else {
	  if ($NuspecVersion -match "REPLACE"){
          Write-Host "WARNING:   ** <version> - contains templated values. This will trigger a message from the verifier:" -Foreground Red
          Write-Host "           ** Requirement: Nuspec file contains templated values which should be removed." -Foreground Cyan
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
			  if ($scriptFile -match "UPDATE.PS1") {return}
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
		      Write-Host "WARNING:   ** $ScriptFile - has PowerShell syntax errors." -Foreground Red
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
			  if ($InstallScript -match "msiexec"){
			      Write-Warning "  ** $ScriptFile calls msiexec - This will trigger a message from the verifier:"
				  Write-Host "           ** Note: Package automation scripts make use of msiexec. The reviewer will ensure there is a valid reason`n              the package has not used the built-in helpers." -Foreground Cyan
				  $GLOBAL:Notes++
				  }
		      if (($InstallScript -match 'cinst ') -or ($InstallScript -match 'choco install') -or ($InstallScript -match 'choco upgrade') -or ($InstallScript -match ' cup ')){
		          Write-Host "WARNING:   ** $ScriptFile - uses a cinst, choco install, cup, or choco upgrade command." -Foreground Red
			      Write-Host "           ** In automation scripts (.ps1/.psm1), the package has used a chocolatey command that should not be used.`n              Rather a dependency should be taken on a package. Please add dependencies to the nuspec." -Foreground Cyan
			      $GLOBAL:Required++
                 }
          }
}

# Check for correctly named install script
Check-ScriptNames

# FossHub and SourceForge DL links check
Check-DiscouragedDownloadLinks

# Binaries checks
Check-Binaries

# OS index files check
Check-OSIndexFiles

#PNG checks
Check-PNGs

# Check for Internal Packaging Files
Check-PackageInternalFilesIncluded

# Git 'er done ------------------------------------------------------------------------------------------------

# Optimize any images files supported by PngOptimizerCL.exe
Run-PNGOptimizer

if (!$ReduceOutput) {
    Write-Host "CNC found " -NoNewLine -Foreground Magenta
    Write-Host "$GLOBAL:Required REQUIRED changes, " -NoNewLine -Foreground Red
    Write-Host "$GLOBAL:Guidelines GUIDELINE changes, " -NoNewLine -Foreground Yellow
    Write-Host "$GLOBAL:Suggestions SUGGESTED changes, " -NoNewLine -Foreground Yellow
    Write-Host "$GLOBAL:Notes NOTES, " -NoNewLine -Foreground Yellow
    Write-Host "$GLOBAL:FYIs FYIs, " -NoNewLine -Foreground Yellow
    Write-Host "and made $GLOBAL:Fixes changes." -ForeGround Green
}

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

$ENV:ChocolateyPackageVersion=''

if ($recurse) {
    #leave space between output if recursing
    Write-Host "`n" 
}

# main recurse foreach loop ends here
}

if (!$ReduceOutput) {
    Write-Host "`nFound CNC.ps1 useful?" -Foreground White
    Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -Foreground White
    Write-Host "Become a patron at https://www.patreon.com/bcurran3" -Foreground White
}
return

# TDL
# Update CDN checking for "main" as well as "master" post 10/2020
# Check validity of URLs in description, checked by the package verifier as of 01/11/2020
# Reformat invalid Markdown headings automagically
# Move header, footer, and package notes into one XML config file
# Could use a CNC...not updated...-WhatIf message when -UpdateXMLNamespace and -WhatIf are used
# option of displaying useful tips and tweaks (AutoHotKey, BeCyIconGrabber, PngOptimizer, Regshot, service viewer program, Sumo, etc)
# Add option to save to an error log when recursivly checking files
# MAYBE do full params statement and get rid of args checking - low priority
# MAYBE check http links to see if https links are available and report if so - low priority
# MAYBE edit and re-write handling CDATA in description (not sure if there is a need)
# https://github.com/chocolatey/package-validator/wiki/ChecksumShouldBeUsed
# There may be more new validator checking that can be addressed
# What else?
