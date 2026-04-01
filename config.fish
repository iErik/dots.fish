# -> $PATH
# --------

fish_add_path /Users/erik/.spicetify
fish_add_path /Users/erik/.cargo/bin
fish_add_path /Users/erik/.local/bin

# -> Variables
# ------------

set -xg PANERU_CONFIG "$HOME/.config/paneru/paneru.toml"
set -U VAGRANT_DEFAULT_PROVIDER vmware_desktop
set -xg PAGER "less"
set -xg LESS "-R"
set -xg NPM_TOKEN "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"

set -U SXHKD_SHELL sh

set -xg EDITOR "nvim"
set -xg FZF_DEFAULT_COMMAND 'rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'

# -> Aliases
# ----------

alias ts="tmux new-session -t"
alias ta="tmux a -t"
alias tk="tmux kill-session -t"
alias tls="tmux ls"

alias vu="vagrant up"
alias vd="vagrant destroy -f"
alias vs="vagrant ssh"
alias vp="vagrant provision"

alias l "ls -Alh"
alias rm "rm -i"
alias less "less -x2RsX"
alias sudo "sudo "

function tgs -w tmux -d 'Creates a group session'
  tmux new-session -t $argv[1] -s $argv[2]
end

# -> Scripts
# ----------

# Restore PyWal's last theme
#cat ~/.cache/wal/sequences

# FNM (Fast Node Manager)
fnm env --use-on-cd | source

# Starship prompt
# starship init fish | source

# pnpm

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
