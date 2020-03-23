#!/bin/bash

tmux_conf=".tmux.conf-linux"
if [ "$(uname)" == "Darwin" ]; then
  tmux_conf=".tmux.conf-mac"
fi
path="$HOME/dotfiles"

echo "install dot files..."

files=(.bash_aliases .editorconfig .gitconfig .zshenv .zshrc)
pushd $HOME
for file in "${files[@]}"
do
  rm $file
  ln -s "$path/$file"
done

ln -s "$path/$tmux_conf" .tmux.conf
popd

echo "install .config files..."

folders=(nvim powerline tmuxinator)

pushd "$HOME/.config"
for folder in "${folders[@]}"
do
  ln -s "$path/$folder"
done
popd

echo "install powerline..."
pip3 install powerline-status

