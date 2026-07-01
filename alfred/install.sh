#!/bin/sh

echo
echo "> alfred/install.sh"

# Alfred 5 does not reliably honour the `syncfolder` default when set headlessly
# (it manages that key via its own UI and overwrites it). Instead we symlink the
# preferences bundle that Alfred reads by default straight to the repo copy, so
# Alfred loads and saves the repo's config transparently.

echo ">> Quitting Alfred (if running)"
osascript -e 'tell application "Alfred 5" to quit' >/dev/null 2>&1
pkill -x Alfred >/dev/null 2>&1
sleep 1

support="$HOME/Library/Application Support/Alfred"
prefs="$support/Alfred.alfredpreferences"
mkdir -p "$support"

# Preserve any real (non-symlink) local bundle before replacing it with the link.
if [ -e "$prefs" ] && [ ! -L "$prefs" ]; then
  echo ">> Backing up existing local Alfred preferences"
  mv "$prefs" "$prefs.backup-$(date +%Y%m%d%H%M%S)"
fi
rm -f "$prefs"

echo ">> Linking Alfred preferences to the repo"
ln -s "`pwd`/alfred/Alfred.alfredpreferences" "$prefs"

echo ">> Relaunching Alfred"
open -a "Alfred 5" >/dev/null 2>&1
