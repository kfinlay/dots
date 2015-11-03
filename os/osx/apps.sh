#
# Application installer (via brew-cask)
#

set -e

# Apps
masapps=(
	529456740 # CheatSheet
	414568915 # Key Codes
	587512244 # Kaleidoscope
	409183694 # Keynote
	492081694 # Houdini
	405219581 # PDF Toolkit
	418889511 # Scrivener
	411246225 # Caffeine
	634108295 # Acorn
	937984704 # Amphetamine
	425424353 # The Unarchiver
	443987910 # 1Password
	429449079 # Patterns
	635758264 # Calca
	880001334 # Reeder
	409203825 # Numbers
	409201541 # Pages
	867299399 # OmniFocus
	415086549 # BetterZip
	928871589 # Noizio
	403624960 # PDFpen
	503981565 # Mindful Mynah
)
commonapps=(
	adobe-reader
	betterzipql
	bibdesk
	box-sync
	burn
	cartographica
	dropbox
	expandrive
	firefox
	flux
	gdal-framework
	google-chrome
	iterm2
	mactex
	management-tools
	matplotlib
	octave
	omnigraffle
	privacy-services-manager
	qgis
	qlcolorcode
	qlmarkdown
	qlprettypatch
	qlstephen
	quicklook-csv
	quicklook-json
	r
	rstudio
	sitesucker
	sketchup
	skim
	skype
	stattransfer11
	sublime-text3
	superduper
	suspicious-package
	textwrangler
	ubersicht
	unrarx
	vlc
	webp-quicklook
)
# gdal-framework and matplotlib are necessary for qgis
kfapps=(
	alfred
	all2mp3
	aviator
	bartender
	bettertouchtool
	bittorrent-sync
	cakebrew
	calibre
	cheatsheet
	citrix-receiver
	commander-one
	controlplane
	dash
	default-folder-x
	disk-inventory-x
	divvy
	dockertoolbox
	duet
	dupeguru
	etrecheck
	eve
	eyetv
	fission
	github
	gitup
	handbrake
	hazel
	hocus-focus
	imagealpha
	imageoptim
	integrity
	jadengeller-helium
	jbidwatcher
	karabiner
	key-codes
	keyboard-maestro
	kismac
	launchcontrol
	launchy
	little-snitch
	loading
	mpv
	nsregextester
	nvalt
	noizio
	ocenaudio
	pacifist
	platypus
	presentation
	seil
	selfcontrol
	shuttle
	sidestep
	slack
	spectacle
	splitshow
	textexpander
	timemachinescheduler
	tower
	transmission
	tunnelblick
	xld
)
kfmacproapps=(
	backblaze-downloader
)
kfmacbookapps=(
	nosleep
	smcfancontrol
	tripmode
	turbo-boost-switcher
)

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
  font-inconsolata
  font-source-code-pro
)
# font-m-plus
# font-clear-sans

# Specify the location of the apps
appdir="/Applications"

main() {
  # Ensure homebrew is installed
  homebrew

  # Ensure mas cli is installed
  mascli

  # Install homebrew-cask
  echo "Installing cask..."
  brew install caskroom/cask/brew-cask

  # Set caskroom permissions
  mkdir -p /opt/homebrew-cask/Caskroom
  sudo chown -R ${USER}:staff /opt/homebrew-cask

  # Tap alternative versions
  brew tap caskroom/versions

  # install apps
  echo "Installing apps..."
  mas install ${masapps[@]}
  brew cask install --appdir=$appdir ${commonapps[@]}
  # Identify machine
  model=$(ioreg -c "IOPlatformExpertDevice" | awk -F '"' '/model/ {print $4}')
  echo $model
  if [ "${model:0:6}" = "MacPro" ]; then
    brew cask install --appdir=$appdir ${kfapps[@]}
    brew cask install --appdir=$appdir ${kfmacproapps[@]}
  fi
  if [ "${model:0:7}" = "MacBook" ]; then
    brew cask install --appdir=$appdir ${kfapps[@]}
    brew cask install --appdir=$appdir ${kfmacbookapps[@]}
  fi

  install fonts
  echo "Installing fonts..."
  brew tap caskroom/fonts
  brew cask install ${fonts[@]}

  # link with alfred
  alfred

  # cleanup
  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

mascli() {
  if test ! $(which mas); then
    echo "Installing mas..."
    brew install argon/mas/mas
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
