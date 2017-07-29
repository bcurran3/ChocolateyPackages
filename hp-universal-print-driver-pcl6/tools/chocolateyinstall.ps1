$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'hp-universal-print-driver-pcl6' 
$url            = 'http://ftp.hp.com/pub/softlib/software13/COL40842/ds-99353-14/upd-pcl6-x32-6.4.1.22169.exe'
$checksum       = '126D541656C94DA2B3CD3FD9EF0BEB91C876393FC16308CA4D98202A5F1D4A9A'
$url64          = 'http://ftp.hp.com/pub/softlib/software13/COL39348/lj-95981-14/upd-pcl6-x64-6.4.1.22169.exe'
$checksum64     = '9C82B48D511E8F05144387662E6B8EC8EC834B20314B6C00B173B37C9A7512E0'
$installerType  = 'ZIP'
$silentArgs     = '/dm /nd /npf /q /h'
$validExitCodes = @(0, 3010, 1641)
$softwareName   = ''
$fileLocation   = "$toolsDir\install.exe"
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "UPDinstall.ahk"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs 

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}
 
Install-ChocolateyInstallPackage @packageArgs

#Remove-Item "$toolsDir\*.exe" | out-null




===============================================================================================
|||||||||||||||||||||||||||||      BEGIN INSTALL.EXE /?     |||||||||||||||||||||||||||||||||||
===============================================================================================

Installer Operation

/aml<"Name","Path"> Adds a Managed List Name using the specified URL or UNC path

/dgst - Disables the HP UPD Services tab for all print queues

/dm Installs the HP UPD in Dynamic Mode

/gcfm"<cfm file>" Specifies DCU configuration file to be utilized for new printer installations

/gcomname"<snmp community name>" Specifies a system global SNMP community name.  The community name cannot end with a number

/h Hides the installer window

/infremove Remove all versions of HP Universal Printing Driver from the Windows driver store. The /q and /h switches are required. No other switches are supported with /infremove

/infstage Stage driver files to Windows driver store for printer plug and play software first installation. The /q and /h switches are required. No other switches are supported with /infstage

/m - driver version name need not be specified while installing. The /sm switch is required. Cannot be used with /sm\server\printer.

/n"<Printer Name>" Uses the specified name as the name of the printer

/nd Does not set the printer as the default

/ni Does not perform the printer installation, only processes other install options

/npf Don't open the Printers folder on completion

/q Quiet mode, no prompts

/qcomname"<snmp community name>" Creates a queue-specific SNMP community name. The community name cannot end with a number

/s<\virtualspooler> Specifies a cluster virtual server where the queue is to be installed.  Must be run from a physical node with administrative privileges

/sc Simple confirmation

/sm<Port> Creates a traditional mode printer bound to the specified <Port>. Local ports require ALL CAPS and a ':'

/tm Installs the printer in Traditional Mode

/u Use the existing printer driver if it's already installed

===============================================================================================

Examples:

install.exe /dm /npf /h /aml"LaserJet Printers","http://printserver/printerlist.asp"

install.exe /gcfm"c:\temp\duplex.cfm"

install.exe /h /nd

install.exe /infstage /h /q

install.exe /n"HP Color LaserJet Enterprise M750"

install.exe /ni /aml"Accounting OfficeJet Printers","\\printserver\hpoj.xml"

install.exe /ru /npf /h

install.exe /ru /npf /h /aml" LaserJets","http://printserver/userlist.asp"

install.exe /s"\\PrintServer1" /tm /n"HP LaserJet Enterprise flow M830 MFP"

install.exe /sc /npf /h

install.exe /sc /npf /h /n"HP Officejet Enterprise Color Flow MFP X585"

install.exe /smhostname /n"Radiology LaserJet"

install.exe /sm192.168.1.111 /n"HP LaserJet MFP M725"

install.exe /sm\\server\M880 /n"HP Color LaserJet flow MFP M880"

install.exe /smLPT1: /n"test printer"

===============================================================================================

Policy switches for use with AD template or MPA

/dmpa - Disables MPA functionality for the current user.

/empa - Enables the MPA functionality for the current user. Default MPA functionality will be retrieved from managed-print.

/gempa - Enables the MPA functionality for all users.

/gpolicy - Specifies the HP MPA Policy URL for all users.

/mppqs - Used to specify additional MPA http query string parameters. Rarely used because the /policy option allows for full URL specification including URI parameters.

/policy - Enables HP MPA policy checking for all users using current policy settings

/pqdads - Disables ADS support only for the current print queue.

/pqdmpa - Disables MPA support only for the current printer being installed. This allows a specific queue to be excluded from MPA policy management.

/ru Restricted user mode, only display HP Managed Printer Lists

===============================================================================================

For more information, please see the System Administrator's guide at http://www.hp.com/go/upd

===============================================================================================

