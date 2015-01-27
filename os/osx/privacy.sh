###############################################################################
# Privacy service manager settings
###############################################################################

if [ "$USER" = "kfinlay" ]
then
	if test ! $(which app_lookup.py); then
	  echo "Installing management tools..."
	  brew cask install --appdir=/Applications management-tools
	fi
	if test ! $(which privacy_services_manager.py); then
	  echo "Installing privacy services manager..."
	  brew cask install --appdir=/Applications privacy-services-manager
	fi
	# to get bundle ID: app_lookup.py safari
	# contacts
	for BID in com.alfredapp.Alfred com.smileonmymac.textexpander
	do
		privacy_services_manager.py add contacts $BID
	done
	# accessibility
	for BID in com.alfredapp.Alfred com.hegenberg.BetterTouchTool cheatsheet org.pqrs.Karabiner-AXNotifier com.stairways.keyboardmaestro.engine com.stairways.keyboardmaestro com.divisiblebyzero.Spectacle com.smileonmymac.textexpander.helper com.smileonmymac.textexpander
	do
		privacy_services_manager.py add accessibility $BID
	done
	# calendar
	for BID in com.omnigroup.OmniFocus2.MacAppStore
	do
		privacy_services_manager.py add calendar $BID
	done
	# reminders
	for BID in com.alfredapp.Alfred com.omnigroup.OmniFocus2.MacAppStore
	do
		privacy_services_manager.py add reminders $BID
	done
	# location
	for BID in org.herf.Flux com.apple.reminders weather com.apple.Maps
	do
		privacy_services_manager.py add location $BID
	done
fi

exit 0
