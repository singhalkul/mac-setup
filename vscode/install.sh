#!/bin/sh

echo
echo "> vscode/install.sh"

target="$HOME/Library/Application Support/Code/User"
mkdir -p "$target"

echo ">> Symlinking VS Code settings (extensions are handled by the Brewfile)"
ln -sf "`pwd`/vscode/settings.json" "$target/settings.json"
[ -f "`pwd`/vscode/keybindings.json" ] && ln -sf "`pwd`/vscode/keybindings.json" "$target/keybindings.json"
