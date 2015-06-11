###############################################################################
# Configs to do by hand
###############################################################################

set -e

# Manually install from Mac App Store
masapps=(
	1Password
	Acorn
	Amphetamine
	BetterZip
	Calca
	CloudPull
	Kaleidoscope
	OmniFocus-2
	Patterns
	Reeder-2
	Revisions-for-Dropbox
	Scrivener
	XCode
)

# add login items
loginapps=(
	Alfred-2
	Amphetamine
	Backblaze
	Bartender
	BetterTouchTool
	BitTorrent-Sync
	Box-Sync
	CheatSheet
	CloudPull
	ControlPlane
	Default-Folder-X-Helper
	Dropbox
	EVE
	ExpanDrive
	Flux
	HocusFocus
	Karabiner
	Keyboard-Maestro-Engine
	Loading
	Mindful-Mynah
	Noizio
	Seil
	Shuttle
	Spectacle
	TextExpander
	Tunnelblick
	Turbo-Boost-Switcher
	Ubersicht
)

# Allow apps to control computer: System Preferences > Security & Privacy > Privacy > Accessibility
controlapps=(
	Alfred-2
	BetterTouchTool
	CheatSheet
	Dropbox
	EVE
	HocusFocus
	Keyboard-Maestro
	Keyboard-Maestro-Engine
	Spectacle
	TextExpander
	TextExpander-Helper
)

# Safari extensions
safariexts=(
	1Password:-https://agilebits.com/extensions/mac/index.html
	The-Traktor
	Translate
	uBlock:-https://www.ublock.org
	Ultimate-Status-Bar
)

main() {
	for app in "${masapps[@]}"
	do
		echo Please install the following from the Mac App Store: $app
	done
	echo
	for app in "${loginapps[@]}"
	do
		echo Please add the following to login items: $app
	done
	echo
	for app in "${controlapps[@]}"
	do
		echo Please allow the following apps to control the computer: $app
	done
	echo
	for app in "${safariexts[@]}"
	do
		echo Please add the following Safari extensions: $app
	done
	echo
	echo System Preferences
	echo
}

main "$@"

exit 0
