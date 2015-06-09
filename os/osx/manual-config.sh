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
	Alfred 2
	Amphetamine
	Backblaze
	Bartender
	BetterTouchTool
	BitTorrent Sync
	Box Sync
	CheatSheet
	CloudPull
	ControlPlane
	Default Folder X Helper
	Dropbox
	EVE
	ExpanDrive
	Flux
	HocusFocus
	Karabiner
	Keyboard Maestro Engine
	Loading
	Mindful Mynah
	Noizio
	Seil
	Shuttle
	Spectacle
	TextExpander
	Tunnelblick
	Ubersicht
)

# Allow apps to control computer: System Preferences > Security & Privacy > Privacy > Accessibility
controlapps=(
	Alfred 2
	BetterTouchTool
	CheatSheet
	Dropbox
	EVE
	HocusFocus
	Keyboard Maestro
	Keyboard Maestro Engine
	Spectacle
	TextExpander
	TextExpander Helper
)

# Safari extensions
safariexts=(
	1Password: https://agilebits.com/extensions/mac/index.html
	The Traktor
	Translate
	uBlock: https://www.ublock.org
	Ultimate Status Bartender
)

main() {
	printf "Please install the following from the Mac App Store: ${masapps[@]}" 
	# printf "Please add the following to login items: ${loginapps[@]}"
	# printf "Please allow the following apps to control the computer: ${controlapps[@]}"
	# printf "Please add the following Safari extensions: ${safariexts[@]}"
}

main "$@"

exit 0
