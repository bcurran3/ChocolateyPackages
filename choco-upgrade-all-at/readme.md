**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original!
* Read the INSTALL EXAMPLES again before use!
* I personally use and endorse this package/task.

CHANGELOG:
* 0.0.5   - Added abort stuck upgrades feature. "Um, why do I want this?" you're thinking. You want this because sometimes background package installations go wrong. "Go wrong?" you're thinking. Yes, there are a couple scenarios where a Chocolatey package installation/upgrade can hang: if a package needs input, if an AutoHotKey or AutoIt script fails, and all those times a program installer pops up a browser window to tell you "Thank you." These scenarios leave hung processes in the background with no way for you to easily interact with them (They're in the background!). This means they are taking up memory resources for no reason and might cause problems installing other packages or programs. **If** you knew there was a hung process, you could manually stop the task, but who wants to check every day? This will automate checking and stopping any Chocolatey package hung tasks at the time you specify. I recommend setting it to a time an hour or two after you run your updates. 
* 0.0.4.1 - Fixed compatibility with Windows 7 & 8 machines by using SchTasks.exe for everything and not using the Windows 10/Server 2016 only get-scheduledtask cmdlet. Removed PowerShell v4/v5 dependency. 
* 0.0.4   - Added option to run weekly.


Like my [packages](https://chocolatey.org/profiles/bcurran3)? 

Find them useful?

**Want to buy me a beer?**

https://www.paypal.me/bcurran3donations

If applicable, please always consider donating to the developer or purchasing the software first - this includes Chocolatey licensed editions. 



