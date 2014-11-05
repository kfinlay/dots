#!/usr/bin/env bash

set -e

# modules
source "$lib/symlink/index.sh"
source "$lib/is-osx/index.sh"

# Only run if on a Mac
if [ 0 -eq `osx` ]; then
  exit 0
fi

# exit 1
# paths
osx="$os/osx"

# Run each program
# gem install xcode-installer
sh "$osx/binaries.sh"
sh "$osx/apps.sh"
sh "$osx/defaults.sh"
sh "$osx/duti.sh"

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

# Restored by mackup
# # Symlink the profile
# if [[ ! -e "$HOME/.bash_profile" ]]; then
#   echo "symlinking: $osx/profile.sh => $HOME/.bash_profile"
#   symlink "$osx/profile.sh" "$HOME/.bash_profile"
#   source $HOME/.bash_profile
# else
#   echo "$HOME/.bash_profile already exists. remove and run again."
# fi
