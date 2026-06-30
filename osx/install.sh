#!/bin/sh

echo
echo "> osx/install.sh"
sh osx/ui.sh
sh osx/track-and-keyboard.sh
sh osx/menu-and-dock.sh
sh osx/finder.sh
sh osx/screenshots.sh
sh osx/privacy.sh
sh osx/app-defaults.sh

echo "!! Please log out and log back in to apply OSX specific changes"
