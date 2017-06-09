#!/usr/bin/env bash
#
# Application installer (via mascli and brew cask)
#

set -e

# Apps
masapps=(
  529456740  # CheatSheet (1.0.3)
  414568915  # Key Codes (2.1)
  587512244  # Kaleidoscope (2.2.0)
  409183694  # Keynote (6.6.2)
  405219581  # PDF Toolkit (1.8)
  634108295  # Acorn (4.5.8)
  411246225  # Caffeine (1.1.1)
  429449079  # Patterns (1.1.2)
  442168834  # SiteSucker (2.10.3)
  635758264  # Calca (1.3)
  880001334  # Reeder (3.0.3)
  409201541  # Pages (5.6.2)
  404458553  # OmniGraffle 5 (5.4.4)
  415086549  # BetterZip (2.3.3)
  404010395  # TextWrangler (5.5.2)
  409203825  # Numbers (3.6.2)
  928871589  # Noizio (1.5)
  1153157709 # Speedtest (1.3)
  403624960  # PDFpen (5.9.9)
  433471800  # Brisk (1.2.2)
  503981565  # Mindful Mynah (1.9.5)
  418889511  # Scrivener
  492081694  # Houdini
)
kfapps=(
  1password-beta
  adobe-reader
  anaconda
  backblaze-downloader
  bartender
  bettertouchtool
  betterzipql
  bibdesk
  box-sync
  cartographica
  citrix-receiver
  default-folder-x
  disk-inventory-x
  dropbox
  duet
  dupeguru
  eve
  firefox
  fission
  flux
  gdal-framework
  gfxcardstatus
  google-chrome
  handbrake
  hocus-focus
  imagealpha
  imageoptim
  integrity
  iterm2-beta
  jadengeller-helium
  karabiner
  keyboard-maestro
  ksdiff
  little-snitch
  loading
  macdown
  mactex
  pacifist
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-csv
  quicklook-json
  rstudio
  securid
  seil
  selfcontrol
  shuttle
  skim
  skype
  spectacle
  sqlitebrowser
  sublime-text
  superduper
  suspicious-package
  textwrangler
  tower
  ubersicht
  vlc
  webpquicklook
)
kfmacproapps=(
  backblaze
)
kfmacbookapps=(
  nosleep
  macs-fan-control
  turbo-boost-switcher
)

# fonts
fonts=(
  font-inconsolata
  font-source-code-pro
)

main() {
  # Ensure homebrew is installed
  homebrew

  # update homebrew
  homebrew_update

  # Ensure mas cli is installed
  mascli

  # Install homebrew-cask
  # echo "Installing cask..."
  # brew install caskroom/cask/brew-cask

  # Set caskroom permissions
  # mkdir -p /opt/homebrew-cask/Caskroom
  # sudo chown -R ${USER}:staff /opt/homebrew-cask

  # Tap alternative versions
  brew tap caskroom/versions

  # install apps
  echo "Installing apps..."

  # install mas apps
  mas install ${masapps[@]}

  # Identify machine
  model=$(ioreg -c "IOPlatformExpertDevice" | awk -F '"' '/model/ {print $4}')
  echo "$model"
  if [ "${model:0:6}" = "MacPro" ]; then
    brew cask install ${kfapps[@]}
    brew cask install ${kfmacproapps[@]}
  fi
  if [ "${model:0:7}" = "Macmini" ]; then
    brew cask install ${kfapps[@]}
    brew cask install ${kfmacproapps[@]}
  fi
  if [ "${model:0:7}" = "MacBook" ]; then
    brew cask install ${kfapps[@]}
    brew cask install ${kfmacbookapps[@]}
  echo
  fi

  # install fonts
  echo "Installing fonts..."
  brew tap caskroom/fonts
  brew cask install ${fonts[@]}

  # cleanup
  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

homebrew_update() {
  echo "Updating homebrew..."
  brew update && brew upgrade -all && brew upgrade brew-cask && brew cleanup && brew cask cleanup
}

mascli() {
  if test ! $(which mas); then
    echo "Installing mas..."
    brew install mas
  fi
}

cleanup() {
  brew cleanup
}

main "$@"

exit 0
