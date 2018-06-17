$ErrorActionPreference = 'Stop'
$packageName = 'explorer-winconfig'
$pp          = Get-PackageParameters

# Explorer - show file extensions 
if ($pp["SHOWEXTENSIONS"] -ne $null -or $pp["SHOWEXTENSIONS"] -ne '')
     {
      if ($pp["SHOWEXTENSIONS"] -eq "YES" -or $pp["SHOWEXTENSIONS"] -eq "yes" -or $pp["SHOWEXTENSIONS"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -ea SilentlyContinue
          }
	  if ($pp["SHOWEXTENSIONS"] -eq 'NO' -or $pp["SHOWEXTENSIONS"] -eq 'no' -or $pp["SHOWEXTENSIONS"] -eq 'No')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 1 -ea SilentlyContinue
		  }
}

# Explorer - show full path in title bar
if ($pp["SHOWFULLPATH"] -ne $null -or $pp["SHOWFULLPATH"] -ne '')
     {
      if ($pp["SHOWFULLPATH"] -eq "YES" -or $pp["SHOWFULLPATH"] -eq "yes" -or $pp["SHOWFULLPATH"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Value 1 -ea SilentlyContinue
          }
	  if ($pp["SHOWFULLPATH"] -eq 'NO' -or $pp["SHOWFULLPATH"] -eq 'no' -or $pp["SHOWFULLPATH"] -eq 'No')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Value 0 -ea SilentlyContinue
		  }
}

# Explorer - show hidden files 
if ($pp["SHOWHIDDEN"] -ne $null -or $pp["SHOWHIDDEN"] -ne '')
     {
      if ($pp["SHOWHIDDEN"] -eq "YES" -or $pp["SHOWHIDDEN"] -eq "yes" -or $pp["SHOWHIDDEN"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -ea SilentlyContinue
          }
	  if ($pp["SHOWHIDDEN"] -eq 'NO' -or $pp["SHOWHIDDEN"] -eq 'no' -or $pp["SHOWHIDDEN"] -eq 'No')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 2 -ea SilentlyContinue
		  }
	  if ($pp["SHOWHIDDEN"] -eq 'ALL' -or $pp["SHOWHIDDEN"] -eq 'all' -or $pp["SHOWHIDDEN"] -eq 'All')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1 -ea SilentlyContinue
		  }		  
}

# Explorer - show check boxes
if ($pp["SHOWCHECKBOXES"] -ne $null -or $pp["SHOWCHECKBOXES"] -ne '')
     {
      if ($pp["SHOWCHECKBOXES"] -eq "YES" -or $pp["SHOWCHECKBOXES"] -eq "yes" -or $pp["SHOWCHECKBOXES"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Value 1 -ea SilentlyContinue
          }
	  if ($pp["SHOWCHECKBOXES"] -eq 'NO' -or $pp["SHOWCHECKBOXES"] -eq 'no' -or $pp["SHOWCHECKBOXES"] -eq 'No')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Value 0 -ea SilentlyContinue
		  }
}

# Explorer - show encrypted files in color
if ($pp["SHOWENCRYPTED"] -ne $null -or $pp["SHOWENCRYPTED"] -ne '')
     {
      if ($pp["SHOWENCRYPTED"] -eq "YES" -or $pp["SHOWENCRYPTED"] -eq "yes" -or $pp["SHOWENCRYPTED"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "showEncryptCompressedColor" -Value 1 -ea SilentlyContinue
          }
	  if ($pp["SHOWENCRYPTED"] -eq 'NO' -or $pp["SHOWENCRYPTED"] -eq 'no' -or $pp["SHOWENCRYPTED"] -eq 'No')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "showEncryptCompressedColor" -Value 0 -ea SilentlyContinue
		  }
}

# Explorer - show preview pane
if ($pp["SHOWPREVIEWPANE"] -ne $null -or $pp["SHOWPREVIEWPANE"] -ne '')
     {
      if ($pp["SHOWPREVIEWPANE"] -eq "YES" -or $pp["SHOWPREVIEWPANE"] -eq "yes" -or $pp["SHOWPREVIEWPANE"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\DetailsContainer" -Name "DetailsContainer" -Value ([byte[]](0x02,0x00,0x00,0x00,0x01,0x00,0x00,0x00)) -ea SilentlyContinue
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer" -Name "DetailsContainerSizer" -Value ([byte[]](0x3e,0x01,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x49,0x03,0x00,0x00)) -ea SilentlyContinue
          }
	  if ($pp["SHOWPREVIEWPANE"] -eq 'NO' -or $pp["SHOWPREVIEWPANE"] -eq 'no' -or $pp["SHOWPREVIEWPANE"] -eq 'No')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\DetailsContainer" -Name "DetailsContainer" -Value ([byte[]](0x02,0x00,0x00,0x00,0x02,0x00,0x00,0x00)) -ea SilentlyContinue
		  }
}

# Explorer - show details pane
if ($pp["SHOWDETAILSPANE"] -ne $null -or $pp["SHOWDETAILSPANE"] -ne '')
     {
      if ($pp["SHOWDETAILSPANE"] -eq "YES" -or $pp["SHOWDETAILSPANE"] -eq "yes" -or $pp["SHOWDETAILSPANE"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\DetailsContainer" -Name "DetailsContainer" -Value ([byte[]](0x01,0x00,0x00,0x00,0x02,0x00,0x00,0x00)) -ea SilentlyContinue
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer" -Name "DetailsContainerSizer" -Value ([byte[]](0x3e,0x01,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x49,0x03,0x00,0x00)) -ea SilentlyContinue
          }
	  if ($pp["SHOWDETAILSPANE"] -eq 'NO' -or $pp["SHOWDETAILSPANE"] -eq 'no' -or $pp["SHOWDETAILSPANE"] -eq 'No')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\DetailsContainer" -Name "DetailsContainer" -Value ([byte[]](0x02,0x00,0x00,0x00,0x02,0x00,0x00,0x00)) -ea SilentlyContinue
		  }
}

# Explorer - show view choices
# THIS DOES NOT WORK YET
if ($pp["VIEW"] -ne $null -or $pp["VIEW"] -ne '')
     {
	 Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\ShellBags" -ea SilentlyContinue
      if ($pp["VIEW"] -eq "DETAILS" -or $pp["VIEW"] -eq "details" -or $pp["VIEW"] -eq "Details")
          {
           New-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags"
		   New-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders"
		   New-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell"
		   New-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" -Name "{5C4F28B5-F869-4E84-8E60-F11DB97C5CC7}"
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" -Name "Mode" -Value 4 -ea SilentlyContinue		   
          }
	  if ($pp["VIEW"] -eq 'LIST' -or $pp["VIEW"] -eq 'list' -or $pp["VIEW"] -eq 'List')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Streams" -Name "Settings" -Value ([byte[]](0x08,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x77,0x7e,0x13,0x73,0x35,0xcf,0x11,0xae,0x69,0x08,0x00,0x2b,0x2e,0x12,0x62,0x04,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x43,0x00,0x00,0x00))
		  }
	  if ($pp["VIEW"] -eq 'LARGEICONS' -or $pp["VIEW"] -eq 'largeicons' -or $pp["VIEW"] -eq 'Largeicons')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Streams" -Name "Settings" -Value ([byte[]](0x08,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x77,0x7e,0x13,0x73,0x35,0xcf,0x11,0xae,0x69,0x08,0x00,0x2b,0x2e,0x12,0x62,0x04,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x43,0x00,0x00,0x00))
		  }
	  if ($pp["VIEW"] -eq 'SMALLICONS' -or $pp["VIEW"] -eq 'smallicons' -or $pp["VIEW"] -eq 'Smallicons')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Streams" -Name "Settings" -Value ([byte[]](0x08,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x77,0x7e,0x13,0x73,0x35,0xcf,0x11,0xae,0x69,0x08,0x00,0x2b,0x2e,0x12,0x62,0x04,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x43,0x00,0x00,0x00))
		  }		  
}

# Explorer - hide drives with no media
if ($pp["SHOWDRIVESNOMEDIA"] -ne $null -or $pp["SHOWDRIVESNOMEDIA"] -ne '')
     {
      if ($pp["SHOWDRIVESNOMEDIA"] -eq "YES" -or $pp["SHOWDRIVESNOMEDIA"] -eq "yes" -or $pp["SHOWDRIVESNOMEDIA"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideDrivesWithNoMedia" -Value 0 -ea SilentlyContinue
          }
	  if ($pp["SHOWDRIVESNOMEDIA"] -eq 'NO' -or $pp["SHOWDRIVESNOMEDIA"] -eq 'no' -or $pp["SHOWDRIVESNOMEDIA"] -eq 'No')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideDrivesWithNoMedia" -Value 1 -ea SilentlyContinue
		  }
}

# Explorer - use sharing wizard
if ($pp["USESHARINGWIZARD"] -ne $null -or $pp["USESHARINGWIZARD"] -ne '')
     {
      if ($pp["USESHARINGWIZARD"] -eq "YES" -or $pp["USESHARINGWIZARD"] -eq "yes" -or $pp["USESHARINGWIZARD"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SharingWizardOn" -Value 1 -ea SilentlyContinue
          }
	  if ($pp["USESHARINGWIZARD"] -eq 'NO' -or $pp["USESHARINGWIZARD"] -eq 'no' -or $pp["USESHARINGWIZARD"] -eq 'No')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SharingWizardOn" -Value 0 -ea SilentlyContinue
		  }
}

Stop-Process -ProcessName Explorer
