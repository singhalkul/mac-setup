if status is-interactive
    # Commands to run in interactive sessions can go here
end

[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

set -g theme_display_git_default_branch yes
set -g theme_display_k8s_namespace yes

# Runtime version management (Java/Node/Python) via mise.
mise activate fish | source

direnv hook fish | source
set -g direnv_fish_mode eval_on_arrow    # trigger direnv at prompt, and on every arrow-based directory change (default)
set -g direnv_fish_mode eval_after_arrow # trigger direnv at prompt, and only after arrow-based directory changes before executing command
set -g direnv_fish_mode disable_arrow    # trigger direnv at prompt only, this is similar functionality to the original behavior

export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export DOCKER_HOST="unix://$HOME/.colima/default/docker.sock"

# uv
fish_add_path "$HOME/.local/bin"

# Work-specific env vars and credentials live in conf.d/secrets.fish
# (gitignored; auto-sourced before this file). See shell/secrets.fish.example.
