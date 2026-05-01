self: { pkgs, lib, config, ... }: let

  inherit (lib) mkOption mkIf types;
  inherit (lib.hm.dag) entryBefore;
  inherit (config.home) username homeDirectory;

  cfg = config.dots.fish;
  dotsDir = "${homeDirectory}/${cfg.directory}";
  xdgConfDir = "${homeDirectory}/.config/fish";
  repoUrl = "git@github.com:iErik/dots.fish.git";

  setupNames = builtins.attrNames (lib.filterAttrs
    (n: v: v == "directory")
    (builtins.readDir ../setups));
in {
  options.dots.fish = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Fish's Dotfiles module";
    };

    cloneConfig = mkOption {
      type = types.bool;
      default = true;
      description =
        "Whether or not to clone the Dotfiles" +
        "repository to the user's directory";
    };

    directory = mkOption {
      type = types.str;
      default = "Dots/Fish.dots";
      description =
        "The path of the directory in which to " +
        "store the dotfiles (relative to the " +
        "user's home directory).";
    };

    branch = mkOption {
      type = types.str;
      default = "master";
      description = "Git branch to clone";
    };

    setup = mkOption {
      type = types.nullOr (types.enum setupNames);
      default = null;
      description =
        "Which per-machine setup directory from " +
        "setups/ to source alongside the main config. " +
        "Value must match a subdirectory name in " +
        "setups/. All *.fish files inside the chosen " +
        "directory are sourced after conf.d/. Set to " +
        "null to not include any.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.oh-my-fish ];

    programs.fish.enable = true;

    home.activation.fishSetup = mkIf cfg.cloneConfig
      (entryBefore ["checkLinkTargets"] ''
        export PATH=${pkgs.openssh}/bin:$PATH
        export PATH=${pkgs.git}/bin:$PATH

        eval $(ssh-agent -s)
        ssh-add

        if [ -d "${dotsDir}/.git" ];
        then
          cd ${dotsDir} && git pull origin ${cfg.branch}
        else
          rm -rf ${dotsDir}
          rm -rf ${xdgConfDir}

          git clone ${repoUrl} ${dotsDir}

          chown -R ${username} ${dotsDir}
          find ${dotsDir} -type d -exec chmod 744 {} \;
          find  ${dotsDir} -type f -exec chmod 644 {} \;

          ln -s ${dotsDir} ${xdgConfDir}
        fi

        rm -f ${dotsDir}/conf.d/99-setup.fish
        ${lib.optionalString (cfg.setup != null) ''
          cat > ${dotsDir}/conf.d/99-setup.fish <<'EOF'
          set -l setup_dir $__fish_config_dir/setups/${cfg.setup}
          if test -d $setup_dir
              for f in (find $setup_dir -maxdepth 1 -type f -name '*.fish' | sort)
                  source $f
              end
          end
          EOF
        ''}

        ssh-agent -k
      '');
  };
}

