{
  description = "Erik's personal Fish shell dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, ... }: {
    homeManagerModules = {
      default = self.homeManagerModules.dots;
      dots = import ./nix/default.nix self;
    };

  };
}
