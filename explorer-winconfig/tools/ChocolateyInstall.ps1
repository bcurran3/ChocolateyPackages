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
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 0 -ea SilentlyContinue		   
          }
	  if ($pp["SHOWHIDDEN"] -eq 'NO' -or $pp["SHOWHIDDEN"] -eq 'no' -or $pp["SHOWHIDDEN"] -eq 'No')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 2 -ea SilentlyContinue
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 0 -ea SilentlyContinue		   
		  }
	  if ($pp["SHOWHIDDEN"] -eq 'ALL' -or $pp["SHOWHIDDEN"] -eq 'all' -or $pp["SHOWHIDDEN"] -eq 'All')
	      {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -ea SilentlyContinue		  
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
		   Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCompColor" -Value 1 -ea SilentlyContinue
          }
	  if ($pp["SHOWENCRYPTED"] -eq 'NO' -or $pp["SHOWENCRYPTED"] -eq 'no' -or $pp["SHOWENCRYPTED"] -eq 'No')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "showEncryptCompressedColor" -Value 0 -ea SilentlyContinue
		   Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCompColor" -Value 0 -ea SilentlyContinue		   
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

# Explorer - use view choice
if ($pp["USEVIEW"] -ne $null -or $pp["USEVIEW"] -ne '')
     {
	  Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags" -recurse -force -ea SilentlyContinue
	  Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU" -recurse -force -ea SilentlyContinue
      New-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags" -ea SilentlyContinue | Out-Null
	  New-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders" -ea SilentlyContinue | Out-Null
	  New-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" -ea SilentlyContinue | Out-Null
	  New-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell\{5C4F28B5-F869-4E84-8E60-F11DB97C5CC7}" -ea SilentlyContinue | Out-Null
	  if ($pp["USEVIEW"] -eq 'ICONS' -or $pp["USEVIEW"] -eq 'icons' -or $pp["USEVIEW"] -eq 'Icons')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell\{5C4F28B5-F869-4E84-8E60-F11DB97C5CC7}" -Name "Mode" -Value 1 -ea SilentlyContinue
		  }
	  if ($pp["USEVIEW"] -eq 'LIST' -or $pp["USEVIEW"] -eq 'list' -or $pp["USEVIEW"] -eq 'List')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell\{5C4F28B5-F869-4E84-8E60-F11DB97C5CC7}" -Name "Mode" -Value 3 -ea SilentlyContinue
		  }
      if ($pp["USEVIEW"] -eq "DETAILS" -or $pp["USEVIEW"] -eq "details" -or $pp["USEVIEW"] -eq "Details")
          {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell\{5C4F28B5-F869-4E84-8E60-F11DB97C5CC7}" -Name "Mode" -Value 4 -ea SilentlyContinue
          }
	  if ($pp["USEVIEW"] -eq 'THUMBNAILS' -or $pp["USEVIEW"] -eq 'thumbnails' -or $pp["USEVIEW"] -eq 'Thumbnails')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell\{5C4F28B5-F869-4E84-8E60-F11DB97C5CC7}" -Name "Mode" -Value 5 -ea SilentlyContinue
		  }		  
	  if ($pp["USEVIEW"] -eq 'TILES' -or $pp["USEVIEW"] -eq 'tiles' -or $pp["USEVIEW"] -eq 'Tiles')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell\{5C4F28B5-F869-4E84-8E60-F11DB97C5CC7}" -Name "Mode" -Value 6 -ea SilentlyContinue
		  }	
	  if ($pp["USEVIEW"] -eq 'FILMSTRIP' -or $pp["USEVIEW"] -eq 'filmstrip' -or $pp["USEVIEW"] -eq 'Filmstrip')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell\{5C4F28B5-F869-4E84-8E60-F11DB97C5CC7}" -Name "Mode" -Value 7 -ea SilentlyContinue
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
