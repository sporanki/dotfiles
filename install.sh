#!/bin/sh

[ "${SHELL##/*/}" != "zsh" ] && echo 'You might need to change default shell to zsh: `chsh -s /bin/zsh`'

dir="$HOME/Developer/personal"
mkdir -p $dir
cd $dir
#ASP git clone --recursive https://github.com/paulmillr/dotfiles.git
git clone --recursive https://github.com/longshot2k20/paulmllrdotfiles.git dotfiles
cd dotfiles
sh etc/symlink-dotfiles.sh
