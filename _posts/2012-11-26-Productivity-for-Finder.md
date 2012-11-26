---
layout: post
title: Enhancements for Mac OS X Finder.app
label: enhancements-for-osx-finder
date: 2012-11-26
comments: false
---

Today I'd like to share three AppleScripts with you which really enhanced my general usage of the Finder.app in Mac OS X. If you are not a Mac OS X user, you can stop reading here.

In general Finder.app lacks some features I really wanted to have, among these were
* copy the POSIX path of the selected file/ folder 
* open the selected folder/ file's folder in iTerm2
* open the selected folder/ file's folder in TextWrangler

Fortunately OS X comes along with a good editor for AppleScripts (not to mention Automator) which can be used to enhance the operating system's abilities.

## Copy the POSIX path
To copy the POSIX path of the selected file or folder, you could simply use the following script:

    -- When clicking on the icon
    try
    	tell application "Finder"
    		if selection is {} then
    			set currentPath to POSIX path of (target of the front window as alias)
    		else
    			set currentPath to POSIX path of (selection as alias)
    		end if
    		set the clipboard to currentPath
    	end tell
    on error
    	display dialog "Error copying path to the clipboard" buttons {"Ok"} with icon caution with title "Error"
    end try
    
But as I also wanted to be able to drag & drop a folder on the icon I enhanced the script a bit like the following:

    -- When clicking on the icon
    try
    	tell application "Finder"
    		if selection is {} then
    			set currentPath to POSIX path of (target of the front window as alias)
    		else
    			set currentPath to POSIX path of (selection as alias)
    		end if
    		set the clipboard to currentPath
    	end tell
    on error
    	my finderErrorMsg()
    end try
    
    -- When dropping a folder onto the icon
    on open {droppedFolder}
    	try
    		tell application "Finder"
    			set currentPath to (POSIX path of droppedFolder as text)
    			set the clipboard to currentPath
    		end tell
    	on error
    		my finderErrorMsg
    	end try
    end open
    
    -- Error msg when unable to copy a path to the clipboard
    on finderErrorMsg()
    	display dialog "Unable to copy a path to the clipboard. Make sure Finder is referencing a directory/folder within the file system." buttons {"Ok"} with icon caution with title "Error"
    end finderErrorMsg
    
Then I saved it as an application so you can now download it at https://github.com/aheusingfeld/Snippets/raw/master/mac-os-x/copy_path.app.zip


## Open in TextWrangler
TextWrangler by Bare Bones Software is currently my editor of choice as IMHO it's much better than TextEdit, has many features of its big brother, BBEdit, but still comes for free. You can get Textedit via the Mac AppStore.

As I got the above script working, the adjustment for TextWrangler was a quick win:
    -- When clicking on the icon
    try
    	tell application "Finder"
    		if selection is {} then
    			set currentPath to POSIX path of (target of the front window as alias)
    		else
    			set currentPath to POSIX path of (selection as alias)
    		end if
    	end tell
   		my openTextWrangler(currentPath)
    on error
    	my finderErrorMsg()
    end try
    
    -- When dropping a folder onto the icon
    on open {droppedFolder}
    	try
    		tell application "Finder"
    			set currentPath to (POSIX path of droppedFolder as text)
    		end tell
    		my openTextWrangler(currentPath)
    	on error
    		my finderErrorMsg()
    	end try
    end open

	on openTextWrangler(current)
    	tell application "TextWrangler"
    		activate
    		open current
    	end tell
	end openTextWrangler
    
    -- Error msg when unable to copy a path to the clipboard
    on finderErrorMsg()
    	display dialog "Unable to copy a path to the clipboard. Make sure Finder is referencing a directory/folder within the file system." buttons {"Ok"} with icon caution with title "Error"
    end finderErrorMsg

**Download:** https://github.com/aheusingfeld/Snippets/raw/master/mac-os-x/open-in-TextWrangler.app.zip

## Open in iTerm2
As I might have mentioned before Terminal.app is not my preferred terminal as iTerm2 (http://www.iterm2.com/) comes with a load of benefits. If you don't use it, yet, you should seriously give it a try!

The script for iTerm2 is actually derived from a script I found in the comments of an [article at macosxhints.com](http://www.macosxhints.com/article.php?story=20050924210643297):
    -- cd to the current finder window folder in iTerm. Or drag a folder onto this script to cd to that folder in iTerm.
    -- found this script in the comments of this article: http://www.macosxhints.com/article.php?story=20050924210643297
    
    -- Instructions for use:
    -- paste this script into Script Editor and save as an application to ~/Library/Scripts/Applications/Finder/cd to in iTerm
    -- run via the AppleScript Menu item (http://www.apple.com/applescript/scriptmenu/)
    -- Or better yet, Control-click and drag it to the top of a finder window so it appears in every finder window.
    -- Activate it by clicking on it or dragging a folder onto it.
    
    -- Another nice touch is to give the saved script the same icon as iTerm.
    -- To do this, in the finder, Get info (Command-I) of both iTerm and this saved script.
    -- Click the iTerm icon (it will highlight blue) and copy it by pressing Comand-C.
    -- Click on this script's icon and paste by pressing Command-V.
    
    -- Another way to give it the same icon as iTerm is to save the script as an application bundle (instead of an application),
    --  then copy the icon by entering these commands in iTerm:
    -- $ cd ~/Library/Scripts/Applications/Finder/cd\ to\ in\ iTerm.app/Contents/Resources/
    -- $ rm droplet.icns
    -- $ cp /Applications/iTerm.app/Contents/Resources/iTerm.icns droplet.icns
    -- $ touch ~/Library/Scripts/Applications/Finder/cd\ to\ in\ iTerm.app
    
    -- script was opened by click in toolbar
    on run
    	tell application "Finder"
    		try
    			set currFolder to (folder of the front window as string)
    		on error
    			set currFolder to (path to desktop folder as string)
    		end try
    	end tell
    	CD_to(currFolder, false)
    end run
    
    -- script run by draging file/folder to icon
    on open (theList)
    	set newWindow to false
    	repeat with thePath in theList
    		set thePath to thePath as string
    		if not (thePath ends with ":") then
    			set x to the offset of ":" in (the reverse of every character of thePath) as string
    			set thePath to (characters 1 thru -(x) of thePath) as string
    		end if
    		CD_to(thePath, newWindow)
    		set newWindow to true -- create window for any other files/folders
    	end repeat
    	return
    end open
    
    -- cd to the desired directory in iterm
    on CD_to(theDir, newWindow)
    	set theDir to quoted form of POSIX path of theDir as string
    	tell application "iTerm"
    		activate
    		delay 0.3
    		-- talk to the first terminal 
    		tell the first terminal
    			try
    				-- launch a default shell in a new tab in the same terminal 
    				launch session "Default Session"
    			on error
    				display dialog "There was an error creating a new tab in iTerm." buttons {"OK"}
    			end try
    			tell the last session
    				try
    					-- cd to the finder window
    					write text "cd " & theDir
    				on error
    					display dialog "There was an error cding to the finder window." buttons {"OK"}
    				end try
    			end tell
    		end tell
    	end tell
    end CD_to

**Download:** https://github.com/aheusingfeld/Snippets/raw/master/mac-os-x/iterm-folder.app.zip


## Adding to the Finder
Finally you should unzip the apps and move them somewhere like "~/Applications/". From this location you can then drag & drop them to your Finder's icon bar. This should look like the following:
![Icons in your Finder.app](/gfx/applescript-icons-in-finder.png)

Now (assuming you have iTerm and TextWrangler installed) you can simply select any file in your finder and click on the icons to open the file in the specific application.
You can find all three AppleScripts and apps in my Github Snippets repository at https://github.com/aheusingfeld/Snippets/tree/master/mac-os-x

Please leave error reports and your comments via Github issues or the Discuss plugin. Thanks.