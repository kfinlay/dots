#!/usr/bin/env bash
#
# Binary installer
#

set -e

# binaries
binarylist=(
  coreutils             # gnu utils
  gcc                   # gcc
  git                   # newest git
  gnuplot               # gnuplot
  imagemagick           # image util
  lame                  # mp3 enc
  mackup                # mackup
  mas                   # app store cli
  mpv                   # video player
  onepass               # 1p wrapper
  openssl               # openssl
  pandoc                # pandoc
  pandoc-citeproc       # pandoc
  shellcheck            # linter for st
  sqlite                # sqlite engine
  sshuttle              # poor mans vpn
  terminal-notifier     # notifier interface
  tesseract             # ocr engine
  the_silver_searcher   # better find
  translate-shell       # translate
  trash                 # mac trash util
  wget                  # wget
  youtube-dl            # download vids
  gdbm                  #
  libffi                #
  libyaml               #
  openssl               #
  readline              #
  rename                #
  ack                   #
  gcc48                 #
)

# piplist=(
#   mackup
# )

gemlist=(
  nokogiri              # required for Titler service
)

main() {
  # check if xcode cli installed
  xcodecheck

  # Ensure homebrew is installed
  homebrew

  # update homebrew
  homebrew_update

  # brews
  brew install ${binarylist[@]}

  # custom brews
    # Install more recent versions of some OS X tools
    brew tap homebrew/dupes
    brew install homebrew/dupes/grep

    # Binaries for audio and podcasts
    brew install ffmpeg --with-fdk-aac

  # # python packages with anaconda pip
  # if test ! $(which brew); then
  #   echo "Installing anaconda..."
  #   brew cask install anaconda
  # fi
  # export PATH=/usr/local/anaconda3/bin:"$PATH"
  # pip install ${piplist[@]}

  # ruby gems with os version of ruby
  gem install ${gemlist[@]}

  # cleanup
  cleanup
}

xcodecheck() {
  if test ! $(pkgutil --pkg-info=com.apple.pkg.CLTools_Executables | awk -F '"' '/version: / {print $1}'); then
    echo "Installing XCode CLT..."
    xcode-select --install
  fi
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

homebrew_update() {
  echo "Updating homebrew..."
  brew update && brew upgrade -all && brew cleanup && brew cask cleanup
}

cleanup() {
  brew cleanup
}

main "$@"

exit 0
