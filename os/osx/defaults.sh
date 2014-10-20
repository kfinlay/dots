###############################################################################
# Identify user, machine, and rename machine							  	  #
###############################################################################

if [ "$USER" = "kfinlay" ]
then
	admin="yes"
elif [ "$USER" = "labadmin" ]
then
	admin="yes"
else
	admin="no"
fi
# echo $lab

# Ask for the administrator password upfront
if [ "$USER" = "kfinlay" ]
then
	sudo -v
	# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
	while true; do sudo -n true; sleep 3600; kill -0 "$$" || exit; done 2>/dev/null &
fi

###############################################################################
# Machine-specific set up
###############################################################################

echo Set computer name
sn=$(ioreg -c "IOPlatformExpertDevice" | awk -F '"' '/IOPlatformSerialNumber/ {print $4}')
echo $sn
model=$(ioreg -c "IOPlatformExpertDevice" | awk -F '"' '/model/ {print $4}')
echo $model
if [ "$model" = "iMac12,2" ]
then
	lab="yes"
elif [ "$model" = "iMac12,1" ]
then
	lab="yes"
else
	lab="no"
fi
echo $lab

if [ "$admin" = "yes" ]
then
	if [ "$model" = "iMac12,2" ]
	then
	    sudo scutil --set ComputerName "lab-instructor-$sn"
		sudo scutil --set LocalHostName "lab-instructor-$sn"
		sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "lab-instructor-$sn"
	elif [ "$model" = "MacBookPro8,2" ]
	then
	    sudo scutil --set ComputerName "macbookpro-$sn"
		sudo scutil --set LocalHostName "macbookpro-$sn"
		sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "macbookpro-$sn"
	elif [ "$model" = "MacPro1,1" ]
	then
	    sudo scutil --set ComputerName "macpro-$sn"
		sudo scutil --set LocalHostName "macpro-$sn"
		sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "macpro-$sn"
	elif [ "$model" = "MacPro6,1" ]
	then
	    sudo scutil --set ComputerName "macpro-$sn"
		sudo scutil --set LocalHostName "macpro-$sn"
		sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "macpro-$sn"
	else
	    sudo scutil --set ComputerName "lab-$sn"
		sudo scutil --set LocalHostName "lab-$sn"
		sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "lab-$sn"
	fi
fi



###############################################################################
# Login and startup                                                           #
###############################################################################

echo ""
echo "Disable the sound effects on boot and mute volume"
if [ "$admin" = "yes" ]
then
	sudo nvram SystemAudioVolume=" "
fi
osascript -e "set volume output volume 0"
osascript -e "set volume output muted 1"

echo ""
echo "econlab auto login, but not on instructor or my machines"
if [ "$admin" = "yes" -a "$lab" = "yes" ]
then
	sudo defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser -string "econlab"
fi
if [ "$admin" = "yes" -a "$model" = "iMac12,2" ]
then
	sudo defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser
fi

echo ""
echo "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# echo Login window and login/shutdown tasks
# if [ "$admin" = "yes" ]
# then
# 	defaults -currentHost write com.apple.screensaver askForPassword -int 1
# 	sudo defaults write /Library/Preferences/com.apple.loginwindow HiddenUsersList -array-add "kfinlay"
# 	sudo defaults write /Library/Preferences/com.apple.loginwindow HiddenUsersList -array-add "labadmin"
# 	sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWOTHERUSERS_MANAGED -boolean true
# 	sudo cp -f $HOME/Dropbox/.labadmin/.files/rc.common /etc/rc.common
# 	if [ "$lab" = "yes" ]
# 	then
# 		sudo cp -f $HOME/Dropbox/.labadmin/.startup /Library/Scripts
# 		sudo cp -f $HOME/Dropbox/.labadmin/.shutdown /Library/Scripts
# 		sudo chmod +x /Library/Scripts/.startup
# 		sudo chmod +x /Library/Scripts/.shutdown
# 		sudo defaults write /Library/Preferences/com.apple.loginwindow LoginHook -path /Library/Scripts/.startup
# 		sudo defaults write /Library/Preferences/com.apple.loginwindow LogoutHook -path /Library/Scripts/.shutdown
# 		# sudo cp -f $HOME/Dropbox/.labadmin/.shutdownat2300.plist /Library/LaunchAgents
# 		sudo pmset -a displaysleep 10 disksleep 10 sleep 10 womp 1
# 		sudo pmset autorestart 1
# 		sudo pmset powerbutton 0
# 		sudo pmset repeat shutdown MTWRFSU 23:00:00
# 		sudo pmset repeat wakeorpoweron MTWRF 8:00:00
# 	# else
# 		# Don't screw with my machine
# 		# sudo cp -f /Volumes/work/Dropbox/.labadmin/.startup /Library
# 		# sudo cp -f /Volumes/work/Dropbox/.labadmin/.shutdown /Library
# 		# Don't force shutdown or autowake on my own machines
# 	fi
# 	# Replace "SystemVersion" with one of the following for different stats:
# 	# SystemVersion
# 	# SystemBuild
# 	# SerialNumber
# 	# IPAddress
# 	# DSStatus
# 	# Time
# 	# HostName
# 	sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
# 	sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false
# 	sudo defaults write /Library/Preferences/com.apple.loginwindow StartupDelay -integer 0
# 	sudo defaults write /Library/Preferences/.GlobalPreferences com.apple.mouse.tapBehaviour -integer 1
# 	sudo defaults write /Library/Preferences/.GlobalPreferences com.apple.mouse.enableSecondaryClick -integer 1
# else
# 	pmset -a displaysleep 10 disksleep 10 sleep 30 womp 1
# 	pmset -a autorestart 1
# 	pmset -a powerbutton 0
# 	pmset repeat shutdown MTWRFSU 23:00:00
# 	pmset repeat wakeorpoweron MTWRF 8:00:00
# 	defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false
# fi
if [ "$model" = "iMac12,2" ]
then
	if [ "$admin" = "yes" ]
	then
		sudo pmset -a displaysleep 20 disksleep 30 sleep 90 womp 1
		sudo pmset -a halfdim 1	
	else
		pmset -a displaysleep 15 disksleep 30 sleep 90 womp 1
		pmset -a halfdim 1
	fi
fi

###############################################################################
# General UI/UX
###############################################################################

echo ""
echo "Disabling system-wide resume"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

echo ""
echo "Disabling automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

echo ""
echo "Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# echo ""
# echo "Never go into computer sleep mode"
# systemsetup -setcomputersleep Off > /dev/null

echo ""
echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# characters
	# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
	echo ""
	echo "Displaying ASCII control characters using caret notation in standard text views"
	defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

	echo ""
	echo "Disable smart quotes and smart dashes as they're annoying when typing code"
	defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Save dialog
	echo ""
	echo "Saving to disk (not to iCloud) by default"
	defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

	echo ""
	echo "Expanding the save panel by default"
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
	defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# after boot
	echo ""
	echo "Disable the reopen windows when logging back in option"
	# This works, although the checkbox will still appear to be checked.
	defaults write com.apple.loginwindow TALLogoutSavesState -bool false
	defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false

if [ "$USER" = "econlab" ]
then
	echo ""
	echo "Disable bluetooth"
	#launchctl unload -w /System/Library/LaunchDaemons/com.apple.blued.plist
	defaults write com.apple.Bluetooth.plist ControllerPowerState -bool false
	killall blued

	echo ""
	echo "Disable Airport"
	networksetup -setairportpower en1 off

	echo ""
	echo "Disable keychain for public computers"
	rm ~/Library/Keychains/login.keychain

	echo ""
	echo "Change background to simple color"
	defaults write com.apple.desktop Background '{default = {ImageFilePath = "/Library/Desktop Pictures/Solid Colors/Solid Aqua Graphite.png"; };}'

	echo ""
	echo "clean up Desktop, Documents, and Downloads"
	DATE=`date +%Y-%m-%d-%H-%M-%S`
	echo $DATE
	tar -zc -f /Dropbox/.cleanup/backupDesk-$sn-$USER-$DATE.tar.gz --remove-files $HOME/Desktop/*
	tar -zc -f /Dropbox/.cleanup/backupDocu-$sn-$USER-$DATE.tar.gz --remove-files $HOME/Documents/*
	rm -rf $HOME/Downloads/*
	# Remove files that determine the view options for the folder
	sudo find / -name ".DS_Store" -depth -exec rm {} \;
	
	echo ""
	echo "Hide the Time Machine, Volume, User, and Bluetooth icons"
	for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
	  defaults write "${domain}" dontAutoLoad -array \
	    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
	    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
	    "/System/Library/CoreServices/Menu Extras/User.menu"
	done
	defaults write com.apple.systemuiserver menuExtras -array \
	  "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
	  "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
	  "/System/Library/CoreServices/Menu Extras/Battery.menu" \
	  "/System/Library/CoreServices/Menu Extras/Clock.menu"
fi

# General window options
	echo ""
	echo "Increasing the window resize speed for Cocoa applications"
	defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

	echo ""
	echo "Set sidebar icon size to medium"
	defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

	echo ""
	echo "Always show scrollbars"
	defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
	# Possible values: `WhenScrolling`, `Automatic` and `Always`

	# Disable smooth scrolling
	# (Uncomment if you're on an older Mac that messes up the animation)
	#defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

	echo ""
	echo "Disable opening and closing window animations"
	defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

	echo ""
	echo "Increase window resize speed for Cocoa applications"
	defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

	echo ""
	echo "Save to disk not to iCloud by default"
	defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

	echo ""
	echo "Disable the Are you sure you want to open this application? dialog"
	defaults write com.apple.LaunchServices LSQuarantine -bool false

	# echo "Disable the crash reporter"
	# defaults write com.apple.CrashReporter DialogType -string "none"

	echo ""
	echo "Set Help Viewer windows to non-floating mode"
	defaults write com.apple.helpviewer DevMode -bool true

# echo Restart automatically if the computer freezes
# sudo systemsetup -setrestartfreeze on

# # Never go into computer sleep mode
# systemsetup -setcomputersleep Off > /dev/null

# Users and Groups
# Login Options-> Change fast switching user menu to Icon
# Set up Password, Apple id, Picture , etc.
# Trackpad
# Point & Click
# Unable Tap to Click with one finger
# Change secondary click to right corner
# Uncheck three finger drag
# Scroll and Zoom
# Uncheck all apart from Zoom in and out
# Dock
# Change position to left and make the size of Icons small
# Finder
# Toolbar
# Update to add path, new folder and delete
# Sidebar
# Add home and code directory
# Remove shared and tags
# New finder window to open in the home directory
# Menubar
# Remove the display and bluetooth icons
# Change battery to show percentage symbols
# Spotlight
# Uncheck fonts, images, files etc.
# Uncheck the keyboard shortcuts as we'll be replacing them with Alfred.
# Accounts
# Add an iCloud account and sync Calendar, Find my mac, Contacts etc.

# sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# echo ""
# echo "Disabling OS X Gate Keeper"
# echo "(You'll be able to install any app you want from here on, not just Mac App Store apps)"
# sudo spctl --master-disable
# sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
# defaults write com.apple.LaunchServices LSQuarantine -bool false

# get rid of duplicate apps by reindexing
# /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# echo Menu bar: disable transparency
# defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################

echo ""
echo "Disable natural Lion-style scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo ""
echo "Increasing sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo ""
echo "Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo ""
echo "Disabling press-and-hold for keys in favor of a key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo ""
echo "Setting a blazingly fast keyboard repeat rate (ain't nobody got time fo special chars while coding!)"
defaults write NSGlobalDomain KeyRepeat -int 0

echo ""
echo "Disabling auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo ""
echo "Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

echo ""
echo "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

###############################################################################
# Screen
###############################################################################


if [ "$admin" = "yes" ]
then
	echo ""
	echo "Require password immediately after sleep or screen saver begins"
	defaults write com.apple.screensaver askForPassword -int 1
	defaults write com.apple.screensaver askForPasswordDelay -int 0
fi

echo ""
echo "Save screenshots to the desktop"
defaults write com.apple.screencapture location -string "$HOME/Desktop"

echo ""
echo "Save screenshots in PNG format"
# other options BMP, GIF, JPG, PDF, TIFF
defaults write com.apple.screencapture type -string "png"

echo ""
echo "Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

if [ "$admin" = "yes" -a "$lab" = "yes" ]
then
	echo ""
	echo "Screensaver idle"
	sudo defaults -currentHost write com.apple.screensaver idleTime -int 1200
fi

# echo "Enable subpixel font rendering on non-Apple LCDs"
# defaults write NSGlobalDomain AppleFontSmoothing -int 2

# echo Enable HiDPI display modes requires restart
# sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder
###############################################################################

if [ "$USER" = "econlab" ]
then
	echo ""
	echo "Prohibit finder preferences"
	defaults write com.apple.finder ProhibitFinderPreferences -bool true
	echo ""
	echo "No crash dialog for classes"
	defaults write com.apple.CrashReporter DialogType -string "None"
fi

if [ "$admin" = "yes" -a "$lab" = "yes" ]
then
	echo ""
	echo "Prohibit finder preferences"
	defaults write com.apple.finder ProhibitFinderPreferences -bool false
	echo ""
	echo "No crash dialog for classes"
	defaults write com.apple.CrashReporter DialogType -string "Developer"
	echo ""
	echo "No recent applications"
	sudo defaults write com.apple.recentitems Applications -dict MaxAmount 0

fi

if [ "$admin" = "yes" ]
then
	echo ""
	echo "Finder allow quitting via command Q doing so will also hide desktop icons"
	defaults write com.apple.finder QuitMenuItem -bool true
else
	echo ""
	echo "Finder not allow quitting via command Q doing so will also hide desktop icons"
	defaults write com.apple.finder QuitMenuItem -bool false
fi

echo ""
echo "Finder: disable window animations and Get Info animations"
defaults write com.apple.finder DisableAllAnimations -bool true

echo ""
echo "Show icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

if [ "$admin" = "yes" ]
then
	echo ""
	echo "Finder: show hidden files by default"
	defaults write com.apple.finder AppleShowAllFiles -bool true
	
	echo ""
	echo "Finder: show all filename extensions"
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	echo ""
	echo Disable the warning when changing a file extension
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
	
	echo ""
	echo "Disable the warning before emptying the Trash"
	defaults write com.apple.finder WarnOnEmptyTrash -bool false

	echo ""
	echo "Enable the MacBook Air SuperDrive on any Mac"
	sudo nvram boot-args="mbasd=1"

	echo ""
	echo "Show the ~/Library folder"
	chflags nohidden ~/Library
fi

echo ""
echo "Finder: show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo ""
echo "Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo ""
echo "Finder: allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo ""
echo "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo ""
echo "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo ""
echo "Enable spring loading for directories"
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

echo ""
echo "Remove the spring loading delay for directories"
defaults write NSGlobalDomain com.apple.springing.delay -float 0

echo ""
echo "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo ""
echo "Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo ""
echo "Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

echo ""
echo "Don't Show item info near icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo false" ~/Library/Preferences/com.apple.finder.plist

echo ""
echo "Don't Show item info to the right of the icons on the desktop"
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist

echo ""
echo "Enable snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

echo ""
echo "Increase grid spacing for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

echo ""
echo "Increase the size of icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

echo ""
echo "Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo ""
echo "Don't Empty Trash securely by default takes too long and drive is already encrypted"
defaults write com.apple.finder EmptyTrashSecurely -bool false

echo ""
echo "Enable AirDrop over Ethernet and on unsupported Macs running Lion"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

###############################################################################
# Dock, Mission Control, Spaces, Launchpad, Hot Corners
###############################################################################

# dashboard, mission control, spaces, and launchpad
	echo ""
	echo "Disable Dashboard"
	defaults write com.apple.dashboard mcx-disabled -bool true

	echo ""
	echo "Don't show Dashboard as a Space"
	defaults write com.apple.dock dashboard-in-overlay -bool true

	echo ""
	echo "Dont automatically rearrange Spaces based on most recent use"
	defaults write com.apple.dock mru-spaces -bool false

	echo ""
	echo "Speed up Mission Control animations"
	defaults write com.apple.dock expose-animation-duration -float 0.1

	echo ""
	echo "Dont group windows by application in Mission Control"
	# (i.e. use the old Exposé behavior instead)
	defaults write com.apple.dock expose-group-by-app -bool false
	
	echo ""
	echo "Speeding up Mission Control animations and grouping windows by application"
	defaults write com.apple.dock expose-animation-duration -float 0.1
	defaults write com.apple.dock "expose-group-by-app" -bool true

# dock
	echo ""
	echo "Wipe all (default) app icons from the Dock"
	# This is only really useful when setting up a new Mac, or if you don't use
	# the Dock to launch apps.
	defaults write com.apple.dock persistent-apps -array
	
	echo ""
	echo "Remove the auto-hiding Dock delay"
	defaults write com.apple.dock autohide-delay -int 0

	echo ""
	echo "Remove the animation when hiding/showing the Dock"
	defaults write com.apple.dock autohide-time-modifier -int 0

	echo ""
	echo "Enable the 2D Dock"
	defaults write com.apple.dock no-glass -bool true

	if [ "$admin" = "yes" ]
	then
		echo ""
		echo "Automatically hide and show the Dock"
		defaults write com.apple.dock autohide -bool true
	else
		defaults write com.apple.dock autohide -bool false
	fi

	echo ""
	echo "Make Dock icons of hidden applications translucent"
	defaults write com.apple.dock showhidden -bool true

	echo ""
	echo "Dock on the right"
	defaults write com.apple.dock orientation -string "right"
	
	echo ""
	echo "Dont animate opening applications from the Dock"
	defaults write com.apple.dock launchanim -bool false

	echo ""
	echo "Show indicator lights for open applications"
	defaults write com.apple.dock show-process-indicators -bool true

	echo ""
	echo "Setting the icon size of Dock items to 48 pixels"
	defaults write com.apple.dock tilesize -float 48
	
	echo ""
	echo "Setting Dock to auto-hide and removing the auto-hiding delay"
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock autohide-delay -float 0
	defaults write com.apple.dock autohide-time-modifier -float 0

	echo ""
	echo "Enable highlight hover effect for the grid view of a stack in Dock"
	defaults write com.apple.dock mouse-over-hilite-stack -bool true

	echo ""
	echo "Enable spring loading for all Dock items"
	defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

	echo ""
	echo "Show indicator lights for open applications in the Dock"
	defaults write com.apple.dock show-process-indicators -bool true
	
# echo Reset Launchpad
# find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete

# # Add iOS Simulator to Launchpad
# ln -s /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app /Applications/iOS\ Simulator.app

# Add a spacer to the left side of the Dock (where the applications are)
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Add a spacer to the right side of the Dock (where the Trash is)
#defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

# hot corners
echo Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
if [ "$admin" = "yes" ]
then
	# Top left screen corner → Application windows
	defaults write com.apple.dock wvous-tl-corner -int 3
	# Top left screen corner modifier → Mission Control
	defaults write com.apple.dock wvous-tl-modifier -int 2
	# Top right screen corner → Notification Center
	defaults write com.apple.dock wvous-tr-corner -int 12
	# Top right screen corner modifier → Launchpad
	defaults write com.apple.dock wvous-tr-modifier -int 11
	# Bottom left screen corner → Display sleep
	defaults write com.apple.dock wvous-bl-corner -int 10
	# Bottom left screen corner modifier → Start screen saver
	defaults write com.apple.dock wvous-bl-modifier -int 5
	# Bottom right screen corner → Desktop
	defaults write com.apple.dock wvous-bl-corner -int 4
	# Bottom right screen corner → Disable screen saver
	defaults write com.apple.dock wvous-bl-modifier -int 6
fi

###############################################################################
# Various other apps                                                          #
###############################################################################

if [ "$USER" = "econlab" ]
then
	echo ""
	echo "No document recall in various apps"
	defaults write com.microsoft.Powerpoint NSQuitAlwaysKeepsWindows -bool false
	defaults write com.microsoft.Word NSQuitAlwaysKeepsWindows -bool false
	defaults write com.microsoft.Excel NSQuitAlwaysKeepsWindows -bool false
	defaults write com.apple.Preview NSQuitAlwaysKeepsWindows -bool false
	defaults write com.apple.QuickTimePlayerX NSQuitAlwaysKeepsWindows -bool false
	defaults write com.macromates.TextMate NSQuitAlwaysKeepsWindows -bool false
	defaults write net.sourceforge.skim-app NSQuitAlwaysKeepsWindows -bool false
	defaults write com.barebones.textwrangler NSQuitAlwaysKeepsWindows -bool false
fi

echo Just for Keith
if [ "$admin" = "yes" ]
then
	echo ""
	echo "Expert diskcopy mode"
	defaults write com.apple.diskcopy expert-mode -boolean true
fi

echo ""
echo "Scientific mode for calculator"
defaults write com.apple.calculator ViewDefaultsKey -string "Scientific"

echo ""
echo "Disable automatic Microsoft updates"
defaults write com.microsoft.autoupdate2 HowToCheck -string "Manual"
if [ "$admin" = "yes" ]
then
	sudo defaults write /Library/Preferences/com.microsoft.autoupdate2 HowToCheck -string "Manual"
fi

###############################################################################
# Safari & WebKit
###############################################################################

echo ""
echo "Hiding Safari bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo ""
echo "Hiding Safari sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

echo ""
echo "Disabling Safari thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

echo ""
echo "Enabling Safari debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo ""
echo "Making Safari search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

echo ""
echo "Removing useless icons from Safari bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo ""
echo "Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

echo ""
echo "Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

echo ""
echo "Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

if [ "$USER" = "econlab" ]
then
	echo ""
	echo "For lab users, clear browser prefs and caches"
	rm -rf "~/Library/Application Support/Google"
	rm -f ~/Library/Preferences/com.google.Chrome.plist
	rm -rf ~/Library/Caches/com.google.Chrome
	touch ~/Library/Caches/com.google.Chrome
	rm -rf ~/Library/Caches/Google/Chrome
	touch ~/Library/Caches/Google/Chrome
	rm -rf ~/Library/Caches/Google/Chrome
	touch ~/Library/Caches/Google/Chrome
	rm -rf ~/Library/Caches/Firefox
	touch ~/Library/Caches/Firefox
	rm -rf "~/Library/Application Support/Safari"
	rm -f ~/Library/Preferences/com.apple.Safari.plist
	rm -rf ~/Library/Caches/com.apple.Safari
	touch ~/Library/Caches/com.apple.Safari
	rm -rf ~/Library/Caches/Safari
	touch ~/Library/Caches/Safari
	killall Safari
	open -a Safari
	killall Safari

	echo ""
	echo "Small Safari history"
	defaults write com.apple.Safari WebKitHistoryItemLimit 500
	defaults write com.apple.Safari WebKitHistoryAgeInDaysLimit 0

	echo ""
	echo "No tab recall in Safari or Chrome"
	defaults write com.apple.Safari NSQuitAlwaysKeepsWindows -bool false
	defaults write com.google.Chrome NSQuitAlwaysKeepsWindows -bool false
fi

echo ""
echo "No Safari top sites or Reader in bar"
defaults write com.apple.Safari DebugSafari4IncludeTopSites -boolean false
defaults write com.apple.Safari ProxiesInBookmarksBar '("Top Sites")'

echo ""
echo "Remove flash cache"
rm -rf "$HOME/Library/Caches/Adobe/Flash Player"
rm -rf $HOME/Library/Preferences/Macromedia

if [ "$admin" = "yes" ]
then
	echo "Remove Adobe plug-ins"
	sudo rm -rf /Library/Internet\ Plug-ins/AdobePDFViewer*.plugin
fi

echo "Disable Adobe Updater"
defaults write com.adobe.AdobeUpdater.Admin Disable.Update -bool yes
cd $HOME/Library/LaunchAgents
launchctl remove 'basename com.adobe.ARM.*'
launchctl remove 'basename com.adobe.AAM.*'
rm $HOME/Library/LaunchAgents/com.adobe.ARM.*
rm $HOME/Library/LaunchAgents/com.adobe.AAM.*
if [ "$admin" = "yes" ]
then
	cd /Library/LaunchAgents
	sudo launchctl remove 'basename com.adobe.ARM.*'
	sudo launchctl remove 'basename com.adobe.AAM.*'
	sudo rm /Library/LaunchAgents/com.adobe.ARM.*
	sudo rm /Library/LaunchAgents/com.adobe.AAM.*
fi

echo ""
echo "Disable pdf native viewing in Safari"
defaults write com.apple.Safari WebKitOmitPDFSupport -bool false

# echo "Set Safari's home page to about:blank for faster loading"
# defaults write com.apple.Safari HomePage -string "about:blank"

echo ""
echo "Allow Safari to opening safe files automatically after downloading"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool true

echo ""
echo "Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

echo ""
echo "Don't warn before closing multiple tabs"
defaults write com.apple.Safari ConfirmClosingMultiplePages -boolean false

echo ""
echo "Make Safaris search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

echo ""
echo "Remove useless icons from Safari's bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo ""
echo "Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo ""
echo "Privacy settings: do not track, duck duck go, geolocation settings"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -boolean true
defaults write com.apple.Safari SearchProviderIdentifier -string "com.duckduckgo"
defaults write com.apple.Safari SafariGeolocationPermissionPolicy -int 2

if [ "$admin" = "yes" ]
then
	echo ""
	echo "Enable Safari's debug menu"
	defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
		
	echo ""
	echo "Enable the Develop menu and the Web Inspector in Safari"
	defaults write com.apple.Safari IncludeDevelopMenu -bool true
	defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
	defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
	
	echo ""
	echo "Show full URL in Safari location box"
	defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
fi

###############################################################################
# Mail
###############################################################################

echo ""
echo "Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false


###############################################################################
# Terminal
###############################################################################

echo ""
echo "Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

###############################################################################
# Time Machine
###############################################################################

echo ""
echo "Preventing Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# echo ""
# echo "Disabling local Time Machine backups"
# hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# Messages                                                                    #
###############################################################################

echo ""
echo "Disable automatic emoji substitution (i.e. use plain text smileys)"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

echo ""
echo "Disable smart quotes as it's annoying for messages that contain code"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

echo ""
echo "Disable continuous spell checking"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

###############################################################################
# Mac App Store                                                               #
###############################################################################

echo "Enable the WebKit Developer Tools in the Mac App Store"
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

echo "Enable Debug Menu in the Mac App Store"
defaults write com.apple.appstore ShowDebugMenu -bool true

###############################################################################
# Personal Additions
###############################################################################

echo ""
echo "Disable hibernation (speeds up entering sleep mode)"
sudo pmset -a hibernatemode 0

# echo ""
# echo "Remove the sleep image file to save disk space"
# sudo rm /Private/var/vm/sleepimage
# echo "Creating a zero-byte file insteadâ€¦"
# sudo touch /Private/var/vm/sleepimage
# echo "â€¦and make sure it can't be rewritten"
# sudo chflags uchg /Private/var/vm/sleepimage

echo ""
echo "Disable the sudden motion sensor as it's not useful for SSDs"
sudo pmset -a sms 0

echo ""
echo "Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400

echo ""
echo "Disable computer sleep and stop the display from shutting off"
# sudo pmset -a sleep 0
sudo pmset -a displaysleep 0

echo ""
echo "Disable annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

echo ""
echo "Skim settings"
defaults write -app Skim SKAutoReloadFileUpdate -boolean true

if [ "$USER" = "kfinlay" ]
then
	if test ! $(which which)
	then
		echo ""
		echo "Fish shell"
		echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
		chsh -s /usr/local/bin/fish
	fi
fi

curl -O https://fix-macosx.com/fix-macosx.py && /usr/bin/python fix-macosx.py

###############################################################################
# Kill affected applications
###############################################################################

# for app in "Address Book" "Calendar" "Contacts" "Dashboard" "Dock" "Finder" \
# 	"Mail" "Safari" "SystemUIServer" "Terminal" \
# 	"iCal" "iTunes"; do
# 	killall "$app" > /dev/null 2>&1
# done
echo ""
echo "Done. Note that some of these changes require a logout/restart to take effect."

exit 0
