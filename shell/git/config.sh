#!/bin/sh
cd "$(dirname "$0")/../.." || exit 1   # repo root, independent of caller's CWD

echo ">> Update git config"

git config --global core.editor vim
git config --global init.defaultBranch main

echo ">> Link global gitignore"
mkdir -p ~/.config/git
ln -sf "`pwd`/shell/git/ignore" ~/.config/git/ignore
