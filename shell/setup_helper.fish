function brewfile
  # Tapped formulae (mani, terraform, mongodb-community) are only dropped by
  # `brew bundle dump` when their taps are untrusted. Once the taps are trusted
  # (see `brew trust` in brew/install.sh; persisted in ~/.homebrew/trust.json),
  # dump emits them with `trusted: true`, so no manual re-appending is needed.
  brew bundle dump --file=~/projects/personal/mac-setup/brew/Brewfile --force
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
