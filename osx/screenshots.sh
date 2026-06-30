#!/bin/sh

echo ">> Save screenshots to ~/Screenshots as PNG without window shadows"
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

killall SystemUIServer
