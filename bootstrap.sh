#!/bin/sh
set -e

repo_url="https://github.com/singhalkul/mac-setup.git"
repo_dir="$HOME/projects/personal/mac-setup"

# --- Command Line Tools (provides git) ---
# On a fresh Mac this pops a GUI installer; wait for it to finish.
if ! xcode-select -p >/dev/null 2>&1; then
  echo ">> Installing Command Line Tools — accept the dialog that appears"
  xcode-select --install || true
  printf ">> Waiting for Command Line Tools to finish installing"
  until xcode-select -p >/dev/null 2>&1; do printf "."; sleep 15; done
  echo " done"
fi

# --- Clone (or update) the repo at its PERMANENT location ---
# Cloning here (not a throwaway Downloads copy) means the symlinks that
# install.sh creates point at a path that will still exist afterwards.
echo ">> Fetching mac-setup into $repo_dir"
mkdir -p "$(dirname "$repo_dir")"
if [ -d "$repo_dir/.git" ]; then
  git -C "$repo_dir" pull --ff-only
else
  git clone "$repo_url" "$repo_dir"
fi

cd "$repo_dir"
echo ">> Running install"
sh install.sh
