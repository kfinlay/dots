#!/usr/bin/env bash
###############################################################################
# Privacy service manager settings
###############################################################################

set -eu

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
	for BID in com.runningwithcrayons.Alfred-3
	do
		sudo privacy_services_manager.py --user "kfinlay" add contacts $BID
	done
	# accessibility
	for BID in com.runningwithcrayons.Alfred-3 com.hegenberg.BetterTouchTool com.mediaatelier.CheatSheet com.stclairsoft.DefaultFolderX5 com.getdropbox.dropbox com.togo.hotkeyEVE org.pqrs.Karabiner-AXNotifier com.stairways.keyboardmaestro.engine com.stairways.keyboardmaestro com.stairways.keyboardmaestro.editor com.divisiblebyzero.Spectacle com.fournova.Tower2
	do
		sudo privacy_services_manager.py --user "kfinlay" add accessibility $BID
	done
	# # calendar
	# for BID in com.omnigroup.OmniFocus2.MacAppStore
	# do
	# 	sudo privacy_services_manager.py --user "kfinlay" add calendar $BID
	# done
	# reminders
	for BID in com.runningwithcrayons.Alfred-3 # com.omnigroup.OmniFocus2.MacAppStore
	do
		sudo privacy_services_manager.py --user "kfinlay" add reminders $BID
	done
	# location
	for BID in org.herf.Flux com.apple.reminders com.apple.Maps tracesOf.Uebersicht com.ookla.speedtest-macos
	do
		sudo privacy_services_manager.py --user "kfinlay" add location $BID
	done
fi

exit 0
