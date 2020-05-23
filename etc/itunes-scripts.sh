#!/bin/sh
#set -x
#file needs to be run from ~/Developer/personal/dotfiles

dev="$HOME/Developer"
dotfiles="$dev/personal/dotfiles"
musicscripts="$HOME/Library/Music/Scripts"

echo ""
if [ -d "$dotfiles" ]; then
  echo "Symlinking itunes scripts from $dotfiles"
else
  echo "$dotfiles does not exist"
  exit 1
fi

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}

for location in $(find itunes -name '*.applescript'); do
  file="${location##*/}"
  file="${file%.applescript}"
  link "$dotfiles/$location" "$musicscripts/$file"
done