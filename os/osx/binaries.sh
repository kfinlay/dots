#
# Binary installer
#

# Check for XCode CLT
if test ! $(pkgutil --pkg-info=com.apple.pkg.CLTools_Executables | awk -F '"' '/version: / {print $1}'); then
  echo "Installing XCode CLT..."
  xcode-select --install
fi

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
brew update && brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Install the binaries
brew install ack
brew install duti 
brew install ffmpeg
brew install fish 
brew install gcc
brew install git
brew install gnuplot 
brew install graphicsmagick
brew install hub
brew install mackup 
brew install matplotlib
brew install mongo
brew install node
brew install onepass 
brew install pandoc 
brew install python3
brew install rename
brew install sshfs
brew install terminal-notifier 
brew install translate-shell 
brew install trash
brew install tree
brew install webkit2png
brew install wget
brew install zeromq
brew install zopfli
brew linkapps

# ScipySuperpack from https://github.com/fonnesbeck/ScipySuperpack
curl -O https://raw.githubusercontent.com/fonnesbeck/ScipySuperpack/master/install_superpack.sh && sh install_superpack.sh

# Ruby installs from http://andycroll.com/mac/ruby/the-simplest-possible-serious-ruby-on-rails-setup-on-mavericks/
# or see https://gorails.com/setup/osx/10.10-yosemite
brew install gdbm libffi libyaml openssl readline
brew install gcc48
brew install chruby
brew install ruby-install
ruby-install ruby 2.1
# #add to profile
# source /usr/local/share/chruby/chruby.sh
# source /usr/local/share/chruby/auto.sh
# chruby ruby 2.1

# other Ruby stuff
# brew install rbenv
# brew install rbenv-default-gems
# brew install rbenv-gem-rehash
# brew install ruby-build
#echo 'eval "$(rbenv init -)"' >> ~/.config/env.sh
#sourcezsh
#rbenv install 2.1.1
#rbenv rehash
#rbenv global 2.1.1
#gem install bundler
#echo 'bundler' >> "$(brew --prefix rbenv)/#default-gems"
#echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
#gem install jekyll
#gem install kramdown
#gem install rails
#echo 'rails' >> "~/.rbenv/default-gems"
#which gem
#gem update
#gem cleanup

# # Add osx specific command line tools
# if test ! $(which subl); then
#   ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
# fi

# Install spot
if test ! $(which spot); then
  curl -L https://raw.github.com/guille/spot/master/spot.sh -o /usr/local/bin/spot && chmod +x /usr/local/bin/spot
fi

# Remove outdated versions from the cellar
brew cleanup

exit 0
