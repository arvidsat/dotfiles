#!/bin/bash

# Install Alacritty
# First install rustup
curl https://sh.rustup.rs -sSf | sh
rustup override set stable
rustup update stable

git clone https://github.com/jwilm/alacritty.git
cd alacritty
cargo build --release
# TODO: Copy binary from target/release/alacritty
cd ..
rm -rf alacritty

# oh-my-zsh
sh -c '$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)'
ln -sv '~/dotfiles/zsh/.zshrc' '~'

# VIM
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sv '~/dotfiles/nvim/init.vim' '~/.config/nvim/'

