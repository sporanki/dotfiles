#!/usr/bin/env zsh

# A simple script for setting up macOS dev environment.

# if old version installed this is how you remove(brute force)
# sudo rm -rf /Library/Developer/CommandLineTools
# install xcode commandline tools will be prompted for eula
xcode-select --install

pushd .
mkdir -p $HOME/Developer
cd $HOME/Developer

echo 'Enter new hostname of the machine (e.g. macbook-paulmillr)'
read hostname
echo "Setting new hostname to $hostname..."
scutil --set HostName "$hostname"
compname=$(sudo scutil --get HostName | tr '-' '.')
echo "Setting computer name to $compname"
scutil --set ComputerName "$compname"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$compname"

pub=$HOME/.ssh/id_ed25519.pub
echo 'Checking for SSH key, generating one if it does not exist...'
  [[ -f $pub ]] || ssh-keygen -t ed25519

echo 'Copying public key to clipboard. Paste it into your Github account...'
  [[ -f $pub ]] && cat $pub | pbcopy
  open 'https://github.com/account/ssh'

# If we on macOS, install homebrew and tweak system a bit.
if [[ `uname` == 'Darwin' ]]; then
  which -s brew
  if [[ $? != 0 ]]; then
    echo 'Installing Homebrew...'
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Homebrew packages
  brews_str="coreutils \
  diff-so-fancy \
  gnupg \
  grep \
  htop \
  node \
  pbzip2 \
  python \
  python@2 \
  ruby \
  postgresql \
  tree \
  jq \
  wget"
  brews=($(echo $brews_str))
  for i in ${brews[@]}
  do
    brew install $i
  done
    
  # install PyChame community edition
  brew cask install PyCharm-ce
  
  # VS Code
  brew cask install visual-studio-code

  # VS Code extensions  
  ext_str="esbenp.prettier-vscode \
  donjayamanne.githistory \
  idleberg.applescript \
  scalameta.metals \
  DavidAnson.vscode-markdownlint \
  humao.rest-client \
  coenraads.bracket-pair-colorizer"
  exts=($(echo $ext_str))
  for i in ${exts[@]}
  do
    code --install-extension $i
  done

  # Latest java SDKs https://github.com/AdoptOpenJDK/homebrew-openjdk
  brew tap AdoptOpenJDK/openjdk
  brew cask install adoptopenjdk8
  brew cask install adoptopenjdk11
  brew cask install adoptopenjdk14-openj9-large

  # maven
  brew install maven

  # Install gradle
  brew install gradle
  
  # intellij community-edition https://www.code2bits.com/how-to-install-intellij-idea-community-edition-on-macos-using-homebrew/
  brew cask install intellij-idea-ce

  # eclipse https://www.code2bits.com/how-to-install-eclipse-on-macos-using-homebrew/
  brew cask install eclipse-jee

  # scala ide
  brew cask install scala-ide

  # show id3 tags in mp3 other formats
  brew install exiftool

  # tmux
  brew install tmux

  # iterm2
  brew cask install iterm2

  # amazon music app
  brew cask install amazon-music

  # scala
  brew install scala
  # scala package manager(not required but may be useful)
  brew install sbt

  #install docker https://medium.com/@yutafujii_59175/a-complete-one-by-one-guide-to-install-docker-on-your-mac-os-using-homebrew-e818eb4cfc3
  brew install docker docker-machine
  brew cask install virtualbox
  #-> need password
  #-> need to address System Preference setting, and possible re-run`
  docker-machine create --driver virtualbox default
  docker-machine env default
  eval "$(docker-machine env default)"
  docker run hello-world
  docker-machine stop default
fi

echo 'Symlinking config files...'
source 'etc/symlink-dotfiles.sh'

popd
