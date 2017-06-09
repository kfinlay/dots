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

# make sure system is up-to-date
softwareupdate --install --all

# Run Mike McQuaid's strap script to install XCode CLTs, install Homebrew et al., set some good security settings
curl -O https://raw.githubusercontent.com/mikemcquaid/strap/master/bin/strap.sh && /bin/bash strap.sh

# Run each dots program
sh "$osx/security.sh"
sh "$osx/binaries.sh"
sh "$osx/apps.sh"
# sh "$osx/defaults.sh"
# sh "$osx/duti.sh"
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
