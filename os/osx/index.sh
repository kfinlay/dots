#!/usr/bin/env bash
set -eu

# modules
source "$lib/symlink/index.sh"
source "$lib/is-osx/index.sh"

# Only run if on a Mac
if [[ 0 -eq `osx` ]]; then
  exit 0
fi

# exit 1
# paths
osx="$os/osx"

# Under El Capitan, must disable SIP to create /usr/local
# if [[ "$(csrutil status)" = "System Integrity Protection status: enabled." ]]; then
#   echo "Please restart and disable System Integrity Protection:"
#   echo "https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/El_Capitan_and_Homebrew.md"
#   exit 0
# fi
# if [ ! -d "/usr/local" ]; then
#   sudo mkdir /usr/local && sudo chflags norestricted /usr/local
# fi
# sudo chown $(whoami):admin /usr/local && sudo chown -R $(whoami):admin /usr/local

# Run Mike McQuaid's strap script to install XCode CLTs, install Homebrew et al., set some good security settings
curl -O https://raw.githubusercontent.com/mikemcquaid/strap/master/bin/strap.sh && /usr/bin/bash strap.sh

# Run each dots program
sh "$osx/security.sh"
sh "$osx/binaries.sh"
sh "$osx/apps.sh"
sh "$osx/defaults.sh"
sh "$osx/duti.sh"
sh "$osx/privacy.sh"

# prompt for private script, run, then delete
read -p "Please enter the URL for your private bash install script (or enter for none)?" privurl
if [ -n "$privurl" ]; then
  cd "$osx"
  curl -L -o "private.sh" "$privurl"
  sh "$osx/private.sh"
  rm "$osx/private.sh"
fi

# cleanup homebrew's cache
brew cleanup --force -s
rm -rf $(brew --cache)
