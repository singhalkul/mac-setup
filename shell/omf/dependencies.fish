#!/opt/homebrew/bin/fish

omf list | grep bobthefish >/dev/null
if test $status -ne 0
  omf install bobthefish
else
  echo ">>> Theme bobthefish already installed"
end

# omf theme persists the active theme to ~/.config/omf/theme — create it first
# (omf does not create this dir on a fresh install and errors without it).
mkdir -p ~/.config/omf
omf theme bobthefish

omf list | grep bass >/dev/null
if test $status -ne 0
  omf install https://github.com/edc/bass
else
  echo ">>> bass already installed"
end
