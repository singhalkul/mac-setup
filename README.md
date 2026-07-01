# Setting up your machine

1. Ensure your machine is running (at least) OSX Catalina
1. Run `bash <(curl -s https://raw.githubusercontent.com/singhalkul/mac-setup/main/bootstrap.sh)`
1. Log out and back in to apply OSX changes (can be done at the end)
1. Login to the App Store in the background (before mac apps get installed)
1. Restore the list of Manual Items (below)
1. Run `mkdir -p ~/projects/personal && cd ~/projects/personal && git clone git@github.com:singhalkul/mac-setup.git && cd mac-setup && ./install.sh` to move shell configurations to a more permanent path. Restart shell to apply changes
1. Log out and back in to apply OSX changes (can be ignored if it hasn't been already done)

# Updating the codebase over time

## Brew packages
```bash
rm -f brew/Brewfile && brew bundle dump --file=brew/Brewfile
```

Once you have fish setup, the function `brewfile` will do the above command for you.

> Note: `brew/Brewfile` is hand-curated with section comments and only lists
> tools that are actually used. A raw `brew bundle dump` will overwrite those
> comments and re-add everything currently installed — review the diff before
> committing if you regenerate it.

## Runtimes (Java / Node / Python)
Managed by [`mise`](https://mise.jdk.tools) (activated in `shell/config.fish`).
Pin per-project versions with a `.mise.toml` / `.tool-versions`; bare shells
fall back to the Homebrew-installed runtimes. `pyenv`/`jenv`/SDKMAN are no longer
used. `uv` handles Python packaging/envs; `pipenv` remains for legacy Pipfiles.

## OSX settings (or any other plist)
Setup the aliases
```bash
alias bef="rm -f before after && defaults read > before" && alias aft="defaults read > after && code --diff before after"
```

In a directory with write privileges, run `bef`, make the changes you wish to record and then run `aft`. The console will output the differences.

## iTerm2
Open `Preferences > General > Preferences` and set the config path to `<base-path>/mac-setup/iterm2`

Make changes via the iterm2 UI and commit the file.

## Alfred
Automated by `alfred/install.sh`: it symlinks
`~/Library/Application Support/Alfred/Alfred.alfredpreferences` to
`alfred/Alfred.alfredpreferences` in the repo, so Alfred reads and writes the
repo copy directly. Make changes via the Alfred UI and commit them.

(The `defaults`-based "Set preferences folder" approach is intentionally not
used — Alfred 5 manages that key via its own UI and overwrites it when set
headlessly, so the symlink is the reliable route.)

## iStat Menus
Update the menu structure as required

## App preferences (Stats, VS Code, …)
Some app configs are version-controlled and restored by `install.sh`:

* **Stats** and **Dozer** (and any other menu-bar app) — preferences are stored
  as plist exports in `osx/app-defaults/<domain>.plist` and re-applied by
  `osx/app-defaults.sh`. After changing settings in the app, re-capture with
  the `app_defaults_export` fish function (add new domains to it as needed).
* **VS Code** — `vscode/settings.json` (and `keybindings.json` if present) are
  symlinked into `~/Library/Application Support/Code/User/` by
  `vscode/install.sh`. Extensions are handled by the Brewfile (`vscode "…"`).
* **Global gitignore** — `shell/git/ignore` is linked to `~/.config/git/ignore`
  by `shell/git/config.sh`.

Not captured (by design): the **menu-bar icon arrangement** (not reliably
exportable on modern macOS), the **Dock** (no apps pinned), and **Dato**
(sandboxed prefs contain calendar PII).

# Manual items

1. ~/.ssh
1. ~/.gnupg
1. `~/.config/fish/conf.d/secrets.fish` — `install.sh` seeds this from
   `shell/secrets.fish.example`; fill in real values (work env vars, tokens,
   GPG signing keys). It is gitignored — never commit populated secrets.
1. iStat Menus - Menu configurations import
1. **Dozer** (menu-bar hider) — its Homebrew cask is discontinued; install the
   app manually (or switch to a maintained alternative like `jordanbaird-ice`).
   Its preferences are restored automatically from `osx/app-defaults`.
1. Dato / menu-bar icon order — arrange manually.

# Pending items

* OSX
    * Spotlight shortcut (currently done by Bartender)
* Move secrets from plain env vars into the macOS Keychain (see
  `gitlab_token` for the pattern)
* Automate mac-setup checkout process
