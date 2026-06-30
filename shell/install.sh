#!/bin/sh
echo
echo "> Setting up shell"

# --- Make fish the default shell ---
if ! finger "$USER" 2>/dev/null | grep -q "Shell: /opt/homebrew/bin/fish"; then
  echo ">> Changing default shell to fish."
  grep -q '/opt/homebrew/bin/fish' /etc/shells || sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
  chsh -s /opt/homebrew/bin/fish
fi

base=`pwd`
mkdir -p ~/.config/fish/conf.d

echo ">> Linking fish config (config.fish + conf.d fragments)"
# config.fish goes to the top level; every other shell/*.fish is a conf.d fragment.
for f in "$base"/shell/*.fish; do
  case "$f" in
    */config.fish)
      ln -sf "$f" ~/.config/fish/config.fish ;;
    *)
      ln -sf "$f" ~/.config/fish/conf.d/ ;;
  esac
done

echo ">> Ensuring machine-local secrets.fish exists (gitignored)"
if [ ! -f ~/.config/fish/conf.d/secrets.fish ]; then
  cp "$base/shell/secrets.fish.example" ~/.config/fish/conf.d/secrets.fish
  echo ">>> Created secrets.fish from template — fill in real values."
fi

echo ">> Install OMF"
fish ./shell/omf/install.fish

echo ">> Install OMF dependencies"
fish ./shell/omf/dependencies.fish

echo ">> Add fzf bindings"
/opt/homebrew/opt/fzf/install --all

sh ./shell/git/config.sh
