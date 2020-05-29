#!/usr/bin/env zsh

# A simple script for setting up macOS dev environment.

dev="$HOME/Developer"
pushd .
mkdir -p $dev
cd $dev

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

  # Homebrew packages.
  #ASP remove python2 brew install diff-so-fancy gnupg htop node pbzip2 python python@2 ruby postgresql wget
  brew install diff-so-fancy gnupg htop node pbzip2 python python@2 ruby postgresql wget

  # Homebrew vscode
  brew cask install visual-studio-code

  #todo verify code is in path at this point may be set in .zshrc
  # Install vscode extension prettier
  code --install-extension esbenp.prettier-vscode
  # Install applescript(itunes scripts)
  code --install-extension idleberg.applescript

  #ASP install latest sdk https://github.com/AdoptOpenJDK/homebrew-openjdk
  brew tap AdoptOpenJDK/openjdk
  brew cask install adoptopenjdk14-openj9-large

  brew install maven

  # Install gradle
  brew install gradle
  
  # Install intellij https://www.code2bits.com/how-to-install-intellij-idea-community-edition-on-macos-using-homebrew/
  brew cask install intellij-idea-ce

  # Install eclipse https://www.code2bits.com/how-to-install-eclipse-on-macos-using-homebrew/
  brew cask install eclipse-jee

  # show id3 tags in mp3 other formats
  brew install exiftool

  # install tmux
  brew install tmux

  # install iterm2
  brew cask install iterm2
  
  #had issues with virtualbox crashing overnite so uninstalled all... may want to use stable releases for this
  #ASP install docker https://medium.com/@yutafujii_59175/a-complete-one-by-one-guide-to-install-docker-on-your-mac-os-using-homebrew-e818eb4cfc3
  brew install docker docker-machine
  brew cask install virtualbox
  #-> need password
  #-> need to address System Preference setting, and possible re-run`
  docker-machine create --driver virtualbox default
  docker-machine env default
  eval "$(docker-machine env default)"
  docker run hello-world
  docker-machine stop default

  
  # echo 'Tweaking macOS...'
    # source 'etc/macos.sh'

  # https://github.com/sindresorhus/quick-look-plugins
  # echo 'Installing Quick Look plugins...'
  #   brew tap phinze/homebrew-cask
  #   brew install caskroom/cask/brew-cask
  #   brew cask install suspicious-package quicklook-json qlmarkdown qlstephen qlcolorcode
fi

echo 'Symlinking config files...'
  source 'etc/symlink-dotfiles.sh'
  
    echo 'Applying sublime config...'
  st=$(pwd)/sublime/packages
  as="$HOME/Library/Application Support/Sublime Text 3/Packages"
  asprefs="$as/User/Preferences.sublime-settings"
  if [[ -d "$as" ]]; then
    for theme in $st/Theme*; do
      cp -r $theme $as
    done
    rm $asprefs
    cp -r $st/pm-themes $as
  else
    echo "Install Sublime Text https://www.sublimetext.com"
  fi

popd
