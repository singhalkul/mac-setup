#!/bin/sh
echo
echo "> Setting up shell"

finger $USER | grep -q "Shell: /opt/homebrew/bin/fish"
if [ $? != 0 ]; then
  echo ">> Changing default shell to fish."
  sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
  chsh -s /opt/homebrew/bin/fish
fi

echo ">> Remove symlink to current fish scripts"
mkdir -p ~/.config/fish/conf.d
ls -ld ~/.config/fish/conf.d/* | grep mac-setup/shell | grep -o '/Users/.*/\.config/.* -' | cut -d ' ' -f 1 | xargs rm
echo ">> Replace with symlink to in-project .fish scripts file. Open a new shell for scripts to take effect."
ln -s `pwd`/shell/*.fish ~/.config/fish/conf.d

echo ">> Install OMF"
fish ./shell/omf/install.fish

echo ">> Install OMF dependencies"
fish ./shell/omf/dependencies.fish

echo ">> Add fzf bindings"
/opt/homebrew/opt/fzf/install --all

sh ./shell/git/config.sh
