#/bin/bash

OS=$(uname)

# OS specific installing of basic stuff for Ubuntu and OS X at the moment
if [ ${OS} = 'Linux' ]; then

   if [ -f /etc/debian_version ]; then

       echo 'Installing tools for debian-based system...'

       # install system basics
       sudo apt-get install -y git
       sudo apt-get install -y curl

       # Install rlwrap to provide libreadline features with node
       # See: http://nodejs.org/api/repl.html#repl_repl
       sudo apt-get install -y rlwrap

       # Install emacs24
       # https://launchpad.net/~cassou/+archive/emacs
       sudo add-apt-repository -y ppa:cassou/emacs
       sudo apt-get -qq update
       sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

       # install zsh
       apt-get install -y zsh

       # Install Heroku toolbelt
       # https://toolbelt.heroku.com/debian
       wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

   fi;


elif [ ${OS} = 'Darwin' ]; then

    echo "Installing tools for OS X..."

    # Install Apple Command Line Tools for Xcode for Mountain Lion
    TOOLS=clitools.dmg
    curl -o "$TOOLS" http://devimages.apple.com/downloads/xcode/command_line_tools_for_xcode_os_x_mountain_lion_april_2013.dmg
    TMPMOUNT=`/usr/bin/mktemp -d /tmp/clitools.XXXX`
    hdiutil attach "$TOOLS" -mountpoint "$TMPMOUNT"
    installer -pkg "$(find $TMPMOUNT -name '*.mpkg')" -target /
    hdiutil detach "$TMPMOUNT"
    rm -rf "$TMPMOUNT"
    rm "$TOOLS"

    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

    # install important tools that don't come with OS X
    brew install wget


    # Install Heroku toolbelt
    wget -q -O heroku_osx.pkg https://toolbelt.heroku.com/download/osx
    sudo installer -pkg heroku_osx.pkg -target /
    rm heroku_osx.pkg

fi;


# Install nvm: node-version manager
# https://github.com/creationix/nvm
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Oh-my-Zsh install
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

# change standard shell to zsh
chsh -s `which zsh`
