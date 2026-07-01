# mac-setup

Automated setup for a new Mac. One bootstrap command installs the apps, makes
fish the shell, applies macOS defaults, and links app configs — so a fresh
machine ends up matching this one.

## What it sets up
- **Apps & CLI tools** — Homebrew via `brew/Brewfile`: formulae, casks, App
  Store apps (`mas`), VS Code extensions, and `uv`/`npm` globals.
- **Shell** — fish as the default shell with OMF + bobthefish, aliases, and a
  `config.fish` wiring up mise, direnv, colima, autojump and fzf.
- **Runtimes** — Java / Node / Python managed by [`mise`](https://mise.jdk.tools)
  (`uv` for Python packaging; `pipenv` for legacy Pipfiles).
- **macOS defaults** — Dock, Finder, keyboard/trackpad, screenshots, privacy,
  dark mode.
- **App configs** — iTerm2, Alfred, Stats, Dozer, VS Code settings and the
  global gitignore, all symlinked/imported from this repo.

## Repo layout
| Path | Purpose |
|------|---------|
| `bootstrap.sh` | Entry point: installs Command Line Tools, clones this repo to `~/projects/personal/mac-setup`, runs `install.sh`. |
| `install.sh` | Orchestrates the sub-installers below (from the repo root). |
| `brew/` | `Brewfile` (hand-curated) + Homebrew installer. |
| `shell/` | fish `config.fish`, `conf.d` fragments, OMF setup, git config, secrets template. |
| `iterm2/` | iTerm2 preferences (loaded via custom-folder setting). |
| `vscode/` | VS Code `settings.json`. |
| `alfred/` | Alfred preferences bundle (symlinked into place). |
| `osx/` | macOS `defaults` scripts + captured app prefs in `app-defaults/`. |
| `common/` | Shared shell helpers. |

Every script is **idempotent** and **location-independent** (each resolves the
repo root from its own path), so `./install.sh` is safe to re-run from anywhere.

---

# Setting up your machine

1. Ensure your machine is running a recent macOS
1. **Sign in to the App Store first** — the `mas` apps only install if you're signed in
1. Run `bash <(curl -s https://raw.githubusercontent.com/singhalkul/mac-setup/main/bootstrap.sh)`
   - Installs Command Line Tools (accept the dialog), clones this repo to
     `~/projects/personal/mac-setup`, and runs `install.sh` from there — so the
     symlinks it creates point at a permanent location.
   - Enter your password when prompted (Homebrew, `chsh`, iTerm2 plist) and
     accept the app permission dialogs (Alfred, VS Code, …).
1. Restore the list of Manual Items (below)
1. Restart your shell, then log out and back in to apply all macOS changes

> Re-running: `cd ~/projects/personal/mac-setup && ./install.sh` is safe and
> idempotent — it can be run from anywhere (each script resolves the repo root).

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
1. **Secrets** — real credentials live in the macOS **Keychain** (service
   `mac-setup`), loaded on demand by the `load-secrets` fish function
   (`shell/load_secrets.fish`). Store each with
   `security add-generic-password -s mac-setup -a <NAME> -w '<value>' -U`, then
   run `load-secrets`. Non-secret work config (AWS_PROFILE, KOPS_STATE_STORE,
   Cypress usernames/Auth0 IDs, GPG signing) goes in the gitignored
   `~/.config/fish/conf.d/secrets.fish` (seeded from `shell/secrets.fish.example`).
1. iStat Menus - Menu configurations import
1. **Dozer** (menu-bar hider) — its Homebrew cask is discontinued; install the
   app manually (or switch to a maintained alternative like `jordanbaird-ice`).
   Its preferences are restored automatically from `osx/app-defaults`.
1. Dato / menu-bar icon order — arrange manually.

# Pending items

* OSX
    * Spotlight shortcut (currently done by Bartender)
