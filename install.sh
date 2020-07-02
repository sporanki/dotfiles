#!/bin/sh

[ "${SHELL##/*/}" != "zsh" ] && echo 'You might need to change default shell to zsh: `chsh -s /bin/zsh`'

dir="$HOME/Developer/personal"
mkdir -p $dir
cd $dir
git clone --recursive git@github.com:sporanki/dotfiles.git dotfiles
cd dotfiles
sh etc/symlink-dotfiles.sh
