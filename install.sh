#!/bin/sh

# Always run from the repo root, regardless of the caller's working directory,
# so relative paths and symlink targets resolve to this checkout.
cd "$(dirname "$0")" || exit 1

sh brew/install.sh
sh shell/install.sh
sh iterm2/install.sh
sh vscode/install.sh
sh alfred/install.sh
sh osx/install.sh
