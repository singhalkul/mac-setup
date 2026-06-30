#!/bin/sh

echo
echo "> osx/app-defaults.sh"
echo ">> Importing saved app preferences (menu-bar apps, etc.)"

# Each *.plist file name is the app's preference domain. Apps should be quit
# before import, otherwise they may overwrite these on their next exit.
for plist in osx/app-defaults/*.plist; do
  [ -f "$plist" ] || continue
  domain=$(basename "$plist" .plist)
  echo ">>> $domain"
  defaults import "$domain" "$plist"
done
