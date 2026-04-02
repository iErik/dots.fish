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

function hms -d 'Recreates the user profile configuration'
  home-manager switch -b backup --flake "$HOME/Nix#$USER"
end

function nix-rebuild -d 'Creates the operating system from a config file'
  sudo nixos-rebuild switch --flake "$HOME/Nix#Eminence"
end

function sys-rebuild -d 'Rebuilds HomeManager and NixOS\'s config'
  sudo nixos-rebuild switch --flake "$HOME/Nix#Eminence"
  and home-manager switch -b backup --flake "$HOME/Nix#$USER"
end
