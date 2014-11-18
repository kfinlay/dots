#
# Application installer (via brew-cask)
#

set -e

# Apps
commonapps=(
	acorn
	adobe-reader
	betterzipql
	bibdesk
	box-sync
	burn
	caffeine
	cartographica
	dropbox
	expandrive
	firefox
	flux
	google-chrome
	iterm2
	kaleidoscope
	mactex
	octave
	omnigraffle
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
	textmate
	textwrangler
	ubersicht
	unrarx
	vlc
	webp-quicklook
)
kfapps=(
	alfred
	all2mp3
	aviator
	bartender
	bettertouchtool
	betterzip
	cakebrew
	cheatsheet
	controlplane
	dash
	default-folder-x
	disk-inventory-x
	divvy
	dupeguru
	eyetv
	fission
	github
	gitx-rowanj
	handbrake
	hazel
	imagealpha
	imageoptim
	integrity
	jbidwatcher
	karabiner
	key-codes
	keyboard-maestro
	kismac
	launchcontrol
	launchy
	little-snitch
	nsregextester
	nvalt
	ocenaudio
	onepassword
	pacifist
	platypus
	scrivener
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
	xld	
)
kfmacproapps=(
	backblaze-downloader
	cloudpull
)
kfmacbookapps=(
	nosleep
	smcfancontrol
)

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

main() {
  # Ensure homebrew is installed
  homebrew

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
  brew cask install --appdir=$appdir ${commonapps[@]}
  # Identify machine
  model=$(ioreg -c "IOPlatformExpertDevice" | awk -F '"' '/model/ {print $4}')
  echo $model
  if [ "${model:0:6}" = "MacPro" ]; then
    #brew cask install --appdir=$appdir ${kfapps[@]}
    brew cask install --appdir=$appdir ${kfmacproapps[@]}
  fi 
  if [ "${model:0:7}" = "MacBook" ]; then
    brew cask install --appdir=$appdir ${kfapps[@]}
    brew cask install --appdir=$appdir ${kfmacbookapps[@]}
  fi

  # install fonts
  #echo "installing fonts..."
  # brew tap caskroom/fonts
  #brew cask install ${fonts[@]}

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

alfred() {
  brew cask alfred link
}

cleanup() {
  brew cleanup
}

main "$@"

exit 0
