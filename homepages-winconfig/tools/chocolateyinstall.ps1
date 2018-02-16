$ErrorActionPreference = 'Stop'
$packageName = 'homepages-winconfig'
$pp          = Get-PackageParameters
$defaultURL  = "https://www.google.com"
$setURL      = $pp["URL"]

if ($pp["URL"] -eq $null -or $pp["url"] -eq '')
     { 
      Write-Host * homepages-winconfig: No URL provided. -foreground magenta
     } else {
       Write-Host * homepages-winconfig: Using $pp["URL"] for homepages.  -foreground magenta
	   }

if ($pp["ALL"] -eq 'yes' -or $pp["ALL"] -eq 'YES' -or $pp["ALL"] -eq 'Yes')
     {
	  Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Internet Settings" -Name "ProvisionedHomePages" -Value $setURL
	  Set-ItemProperty -Path "HKCU:\Software\Microsoft\Internet Explorer\Main" -Name "Start Page" -Value $setURL
	  $EdgeReady = (Test-path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Internet Settings")
      If ($EdgeReady -ne "True")
        {
         New-Item -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Internet Settings" -Name "ProvisionedHomePages" –Force
        }
	  $NewData = @()	 
	  $Prefsjsfile = Get-Item -Path ($env:SystemDrive+"\Users\*\AppData\Roaming\Mozilla\Firefox\Profiles\*\prefs.js")
	  Copy-Item $Prefsjsfile $Prefsjsfile".bak"
      $Update = "user_pref(""browser.startup.homepage"", ""$setURL"");"
      $Prefsjs = (Get-Content $Prefsjsfile)
      foreach ($line in $Prefsjs)
	    {
         if ($line -like 'user_pref("browser.startup.homepage",*')
            {
	         $line = $Update
             $NewData+= $line
	        } else {
	          $NewData+= $line
	        }
        }
      Clear-Content $Prefsjsfile
      Add-Content $Prefsjsfile $NewData
	  exit
     } else {
	   if ($pp["ALL"] -eq 'no' -or $pp["ALL"] -eq 'NO' -or $pp["ALL"] -eq 'No')
	     {
		  Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Internet Settings" -Name "ProvisionedHomePages" -Value $defaultURL
          Set-ItemProperty -Path "HKCU:\Software\Microsoft\Internet Explorer\Main" -Name "Start Page" -Value $defaultURL
		  $EdgeReady = (Test-path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Internet Settings")
          If ($EdgeReady -ne "True")
            {
             New-Item -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Internet Settings" -Name "ProvisionedHomePages" –Force
            }
		  $NewData = @()	 
	      $Prefsjsfile = Get-Item -Path ($env:SystemDrive+"\Users\*\AppData\Roaming\Mozilla\Firefox\Profiles\*\prefs.js")
	      Copy-Item $Prefsjsfile $Prefsjsfile".bak"
          $Update = "user_pref(""browser.startup.homepage"", ""$defaultURL"");"
          $Prefsjs = (Get-Content $Prefsjsfile)
          foreach ($line in $Prefsjs)
	        {
             if ($line -like 'user_pref("browser.startup.homepage",*')
               {
	            $line = $Update
                $NewData+= $line
	           } else {
	             $NewData+= $line
	           }
           }
         Clear-Content $Prefsjsfile
         Add-Content $Prefsjsfile $NewData	
		 exit
        }
	 }
	   
# Internet Explorer
if ($pp["IE"] -eq "yes" -or $pp["IE"] -eq "YES" -or $pp["IE"] -eq "Yes")
     {
      Set-ItemProperty -Path "HKCU:\Software\Microsoft\Internet Explorer\Main" -Name "Start Page" -Value $setURL
	 } else {
	   if ($pp["IE"] -eq 'no' -or $pp["Ie"] -eq 'NO' -or $pp["IE"] -eq 'No')
	     {
	      Set-ItemProperty -Path "HKCU:\Software\Microsoft\Internet Explorer\Main" -Name "Start Page" -Value $defaultURL
		 }
	 }
# Microsoft Edge
$EdgeReady = (Test-path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Internet Settings")
If ($EdgeReady -ne "True")
   {
    New-Item -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Internet Settings" -Name "ProvisionedHomePages" –Force
   }
	 
if ($pp["EDGE"] -eq "yes" -or $pp["EDGE"] -eq "YES" -or $pp["EDGE"] -eq "Yes")
     {
	   Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Internet Settings" -Name "ProvisionedHomePages" -Value $setURL
	 } else {
	   if ($pp["EDGE"] -eq 'no' -or $pp["EDGE"] -eq 'NO' -or $pp["EDGE"] -eq 'No')
	     {
	      Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Internet Settings" -Name "ProvisionedHomePages" -Value $defaultURL
		 }
	 }	 
# FireFox 
if ($pp["FF"] -eq 'yes' -or $pp["FF"] -eq 'YES' -or $pp["FF"] -eq 'Yes')
     {
      $NewData = @()	 
	  $Prefsjsfile = Get-Item -Path ($env:SystemDrive+"\Users\*\AppData\Roaming\Mozilla\Firefox\Profiles\*\prefs.js")
	  Copy-Item $Prefsjsfile $Prefsjsfile".bak"
      $Update= "user_pref(""browser.startup.homepage"", ""$setURL"");"
      $Prefsjs = (Get-Content $Prefsjsfile)
      foreach ($line in $Prefsjs)
	    {
         if ($line -like 'user_pref("browser.startup.homepage",*')
            {
	         $line = $Update
             $NewData+= $line
	        } else {
	          $NewData+= $line
	        }
           }
        Clear-Content $Prefsjsfile
        Add-Content $Prefsjsfile $NewData
	} else {
	  if ($pp["FF"] -eq 'no' -or $pp["FF"] -eq 'NO' -or $pp["FF"] -eq 'No')
	     {
          $NewData = @()	 
	      $Prefsjsfile = Get-Item -Path ($env:SystemDrive+"\Users\*\AppData\Roaming\Mozilla\Firefox\Profiles\*\prefs.js")
	      Copy-Item $Prefsjsfile $Prefsjsfile".bak"
          $Update = "user_pref(""browser.startup.homepage"", ""$defaultURL"");"
          $Prefsjs = (Get-Content $Prefsjsfile)
          foreach ($line in $Prefsjs)
	        {
             if ($line -like 'user_pref("browser.startup.homepage",*')
            {
	         $line = $Update
             $NewData+= $line
	        } else {
	          $NewData+= $line
	        }
           }
         Clear-Content $Prefsjsfile
         Add-Content $Prefsjsfile $NewData	
        }
	}

# Chrome - hopefully coming soon
# edit C:\Users\username\AppData\Local\Google\Chrome\User Data\Default\Preferences

# Chromium - hopefully coming soon

# Opera - hopefully coming soon
# Preferences - "startup_list", restore_on_startup":4, "urls_signature" (Google signature the same on all machines?)
# https://github.com/CoderDojoPotsdam/software/blob/master/linux-update/set_startup_homepage.sh
