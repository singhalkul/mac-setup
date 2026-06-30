#!/bin/sh

echo ">> Update git config"

git config --global core.editor vim
git config --global init.defaultBranch main

echo ">> Link global gitignore"
mkdir -p ~/.config/git
ln -sf "`pwd`/shell/git/ignore" ~/.config/git/ignore
