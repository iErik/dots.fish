fish_add_path $HOME/.spicetify
fish_add_path $HOME/.config/rofi/scripts
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin

set -U VAGRANT_DEFAULT_PROVIDER vmware_desktop
set -xg NPM_TOKEN ""

set -U SXHKD_SHELL sh
set -xg PAGER "less"
set -xg LESS "-R"
set -xg EDITOR "nvim"
set -g PROJECTS_FOLDER "$HOME/Projects"

set -xg FZF_DEFAULT_COMMAND 'rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
