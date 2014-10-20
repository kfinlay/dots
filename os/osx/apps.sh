#
# Application installer (via brew-cask)
#

set -e

# Identify machine
model=$(ioreg -c "IOPlatformExpertDevice" | awk -F '"' '/model/ {print $4}')
echo $model

# Apps
if [ "$model" = "MacBookPro8,2" ]
then
	apps=(
		acorn
		adobe-reader
		alfred
		all2mp3
		aviator
		bartender
		bettertouchtool
		betterzip
		betterzipql
		bibdesk
		box-sync
		burn
		caffeine
		cake-brew
		cartographica
		cheatsheet
		controlplane
		dash
		default-folder-x
		disk-inventory-x
		divvy
		dropbox
		dupeguru
		expandrive
		eyetv
		firefox
		fission
		flux
		geektool
		github
		gitx-rowanj
		google-chrome
		handbrake
		hazel
		imagealpha
		imageoptim
		integrity
		iterm2
		jbidwatcher
		kaleidoscope
		karabiner
		key-codes
		keyboard-maestro
		kismac
		launchcontrol
		launchy
		little-snitch
		mactex
		monolingual
		nosleep
		nvalt
		ocenaudio
		octave
		omnifocus
		omnigraffle
		onepassword
		pacifist
		qlcolorcode
		qlmarkdown
		qlprettypatch
		qlstephen
		quicklook-csv
		quicklook-json
		r
		scrivener
		seil
		selfcontrol
		shuttle
		sidestep
		sitesucker
		sketchup
		skim
		skype
		slack
		smcfancontrol
		spectacle
		splitshow
		stattransfer11
		sublime-text3
		superduper
		suspicious-package
		textmate
		textwrangler
		timemachinescheduler
		tower 
		transmission
		ubersicht
		unrarx
		vlc
		webp-quicklook
		xld
	)	
elif [ "$model" = "MacPro6,1" ]
then
	apps=(
		acorn
		adobe-reader
		alfred
		all2mp3
		aviator
		backblaze-downloader
		bartender
		bettertouchtool
		betterzip
		betterzipql
		bibdesk
		box-sync
		burn
		caffeine
		cake-brew
		cartographica
		cheatsheet
		cloudpull
		controlplane
		dash
		default-folder-x
		disk-inventory-x
		divvy
		dropbox
		dupeguru
		expandrive
		eyetv
		firefox
		fission
		flux
		geektool
		github
		gitx-rowanj
		google-chrome
		handbrake
		hazel
		imagealpha
		imageoptim
		integrity
		iterm2
		jbidwatcher
		kaleidoscope
		karabiner
		key-codes
		keyboard-maestro
		kismac
		launchcontrol
		launchy
		little-snitch
		mactex
		nvalt
		ocenaudio
		octave
		omnifocus
		omnigraffle
		onepassword
		pacifist
		qlcolorcode
		qlmarkdown
		qlprettypatch
		qlstephen
		quicklook-csv
		quicklook-json
		r
		scrivener
		seil
		selfcontrol
		shuttle
		sidestep
		sitesucker
		sketchup
		skim
		skype
		slack
		spectacle
		splitshow
		stattransfer11
		sublime-text3
		superduper
		suspicious-package
		textmate
		textwrangler
		timemachinescheduler
		tower 
		transmission
		ubersicht
		unrarx
		vlc
		webp-quicklook
		xld
	)
else
	apps=(
		acorn
		adobe-reader
		betterzipql
		bibdesk
		box-sync
		burn
		caffeine
		cartographica
		default-folder-x
		disk-inventory-x
		divvy
		dropbox
		expandrive
		firefox
		flux
		geektool
		google-chrome
		imagealpha
		imageoptim
		integrity
		iterm2
		kaleidoscope
		mactex
		octave
		omnigraffle
		onepassword
		qlcolorcode
		qlmarkdown
		qlprettypatch
		qlstephen
		quicklook-csv
		quicklook-json
		r
		scrivener
		sitesucker
		sketchup
		skim
		skype
		splitshow
		stattransfer11
		sublime-text3
		superduper
		suspicious-package
		textmate
		textwrangler
		ubersicht
		unrarx
		vlc
		webp-quicklook
	)
fi

# patterns - not available
# parallels - not working
	# ==> Downloading http://download.parallels.com/desktop/v9/update2.hotfix2/ParallelsDesktop-9.0.24237.1028877.dmg
	# ######################################################################## 100.0%
	# ==> Running installer for parallels; your password may be necessary.
	# ==> Package installers may write to any location; options such as --appdir are ignored.
	# ==> installer: Package name is Parallels Desktop
	# ==> installer: Installing at base path /
	# ==> installer: The install failed (The Installer encountered an error that caused the installation to fail. Contact the software
	# Error: Command failed to execute!
	#
	# ==> Failed command:
	# ["/usr/bin/sudo", "-E", "--", "/usr/sbin/installer", "-pkg", "#<Pathname:/opt/homebrew-cask/Caskroom/parallels/9.0.24237.1028877/Install.mpkg>", "-target", "/"]
	#
	# ==> Output of failed command:
	# installer: Package name is Parallels Desktop
	# installer: Installing at base path /
	# installer: The install failed (The Installer encountered an error that caused the installation to fail. Contact the software manufacturer for assistance.)

# fonts
fonts=(
  font-m-plus
  font-clear-sans
)

# Specify the location of the apps
appdir="/Applications"

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

main() {

  # Ensure homebrew is installed
  homebrew

  # Install homebrew-cask
  echo "installing cask..."
  brew install caskroom/cask/brew-cask

  # Tap alternative versions
  brew tap caskroom/versions

  # Tap the fonts
  brew tap caskroom/fonts

  # install apps
  echo "installing apps..."
  brew cask install --appdir=$appdir ${apps[@]}

  # install fonts
  #echo "installing fonts..."
  #brew cask install ${fonts[@]}

  # link with alfred
  alfred
  cleanup
  
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

alfred() {
  brew cask alfred link
}

cleanup() {
  brew cleanup
}

main "$@"

exit 0
