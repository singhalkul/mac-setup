#!/bin/sh

echo ">> Setting ~/$USER as the finder home"
defaults write com.apple.finder NewWindowTarget "PfHm"
defaults write com.apple.finder NewWindowTargetPath "file:///Users/$USER/"

echo ">> Default to list view"
defaults write com.apple.finder FXPreferredViewStyle "Nlsv"

echo ">> Show hidden files, path bar, status bar and all file extensions"
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo ">> Don't write .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

killall Finder
