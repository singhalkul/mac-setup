#!/bin/sh

# Trackpad
echo ">> Setup trackpad speed parameters"
defaults write NSGlobalDomain com.apple.trackpad.scaling -int 3

# Mouse
echo ">> Setup mouse speed parameters"
defaults write NSGlobalDomain com.apple.mouse.scaling -int 3
defaults write NSGlobalDomain com.apple.scrollwheel.scaling -int 1

# Keyboard
echo ">> Setup keyboard speed parameters"
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

# Text input (dev-friendly: don't mangle code/config snippets)
echo ">> Disable auto-correct, smart quotes and smart dashes"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
