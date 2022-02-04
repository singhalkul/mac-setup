#!/bin/sh

source common/functions.sh

# Dock
echo ">> Setup dock parameters"
defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock tilesize -float 34
defaults write com.apple.dock largesize -float 128
defaults write com.apple.dock orientation bottom
defaults write com.apple.dock mineffect genie
defaults write com.apple.dock minimize-to-application true
delete_if_available com.apple.dock persistent-apps
defaults write com.apple.dock show-recents -bool false
echo ">> Restarting Dock"
killall Dock

# Siri
echo ">> Hiding Siri"
defaults write com.apple.Siri StatusMenuVisible 0
defaults write com.apple.systemuiserver "NSStatusItem Visible Siri" 0

# Airplay
defaults write com.apple.airplay showInMenuBarIfPresent false

# Time machine
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.TimeMachine" true
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"

echo ">> Restarting SystemUIServer"
killall -KILL SystemUIServer

# Spotlight
# spotlight_key_status=`defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys | tr '    64 =     {\n        enabled = 1;' '    64 =     {\n        enabled = 0;'`
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys "$spotlight_key_status"
