#!/bin/sh

echo ">> Setting ~/$USER as the finder home"
defaults write com.apple.finder NewWindowTarget "PfHm"
defaults write com.apple.finder NewWindowTargetPath "file:///Users/$USER/"

echo ">> Default to list view"
defaults write com.apple.finder FXPreferredViewStyle "Nlsv"

killall Finder
