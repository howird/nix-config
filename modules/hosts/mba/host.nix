{
  inputs,
  den,
  ...
}: {
  flake-file.inputs = {
    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  den.hosts.aarch64-darwin.mba = {
    users.howird = {};
    keymap = "macbook";
  };

  den.aspects.mba.includes = [
    den.aspects.gui
  ];

  den.aspects.mba.darwin = {config, ...}: {
    imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];

    networking.computerName = "mba";
    networking.localHostName = "mba";

    nix-homebrew = {
      enable = true;
      user = config.system.primaryUser;
    };
  };
}
