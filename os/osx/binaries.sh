#
# Binary installer
#

# make sure system is up-to-date
softwareupdate --install --all

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

# python installs
# ScipySuperpack from https://github.com/fonnesbeck/ScipySuperpack
	# installs Python 2.X
curl -O https://raw.githubusercontent.com/fonnesbeck/ScipySuperpack/master/install_superpack.sh && sh install_superpack.sh
# install Python 3.X
brew install python3
# python tools
pip install scrapy

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

# Install zsh
brew install zsh --disable-etcdir

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Binaries I use
brew install duti git gnuplot mackup terminal-notifier translate-shell wget

# Install the binaries
brew install ack fish onepass rename trash tree
# brew install ffmpeg gcc graphicsmagick hub mongo node pandoc sshfs webkit2png zeromq zopfli
brew linkapps

# # Add osx specific command line tools
# if test ! $(which subl); then
#   ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
# fi

# Install linters (chktex, htmltidy, and json built into ST3)
brew install shellcheck

# Install Oh My Zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

	# install zsh-syntax-highlighting
	mkdir -p "${HOME}/.oh-my-zsh/custom/plugins"
	git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

	# add 'oneend' theme
	mv "/tmp/dotfiles/files/oneend.zsh-theme" "${HOME}/.oh-my-zsh/themes/"

	# make default shell
	sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
	chsh -s "/usr/local/bin/zsh"

# Install spot
if test ! $(which spot); then
  curl -L https://raw.github.com/guille/spot/master/spot.sh -o /usr/local/bin/spot && chmod +x /usr/local/bin/spot
fi

# Remove outdated versions from the cellar
brew cleanup

exit 0
