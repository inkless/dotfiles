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
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "install homebrew packages..."
brew install ncdu htop tree \
  nodenv pyenv \
  gh pick ripgrep gotop \
  fzf tmux neovim diff-so-fancy tmuxinator node iterm2

echo "install prettier related stuff..."
npm install -g prettier

echo "install python 3..."
pyenv install 3.7.13
pyenv global 3.7.13

# echo "install protobuf lower version to work with iterm2"
pip3 install --upgrade protobuf==3.20.0

echo "Congratulations! Script completed!!!"
