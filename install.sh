#!/bin/bash

tmux_conf=".tmux.conf-linux"
if [ "$(uname)" == "Darwin" ]; then
  tmux_conf=".tmux.conf-mac"
fi
path="$HOME/dotfiles"

echo "install dot files..."

files=(.bash_aliases .editorconfig .gitconfig .zshenv .zshrc .eslintrc.js .prettierrc.js)
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

while true; do
  read -r -p "Install dev packages? [y/n] " yn
  case $yn in
    [Yy]* ) echo "Confirmed!"; break;;
    [Nn]* ) exit;;
    * ) echo "Please answer y or n";;
  esac
done

echo "install homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "install homebrew packages..."
brew install ncdu htop tree
brew install nodenv pyenv
brew install fzf tmux neovim diff-so-fancy

echo "install node@12, path is already updated in .zshrc"
brew install node@12

echo "install prettier related stuff..."
npm install -g prettier

echo "install python 3..."
pyenv install 3.7.6
pyenv global 3.7.6

echo "install powerline..."
pip3 install powerline-status

echo "Congratulations! Script completed!!!"
