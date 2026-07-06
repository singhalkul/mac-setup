function brewfile
  set -l file ~/projects/personal/mac-setup/brew/Brewfile
  brew bundle dump --file=$file --force
  # `brew bundle dump` omits tap-qualified formulae, so re-append the ones we use.
  for f in alajmo/mani/mani hashicorp/tap/terraform mongodb/brew/mongodb-community mongodb/brew/mongodb-database-tools
    echo "brew \"$f\"" >> $file
  end
end

# Re-capture app preferences into the repo (run after changing settings in the app).
# Add more domains here as you decide to track them.
function app_defaults_export
  set -l repo ~/projects/personal/mac-setup
  for domain in eu.exelban.Stats com.mortennn.Dozer
    defaults export $domain - | plutil -convert xml1 -o $repo/osx/app-defaults/$domain.plist -
    echo "exported $domain"
  end
end
