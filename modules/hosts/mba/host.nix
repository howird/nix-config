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

  den.hosts.aarch64-darwin.mba.users.howird = {
    aspect = den.aspects.howird-mac;
  };

  den.aspects.mba.includes = [
    den.aspects.kanata
  ];

  den.aspects.mba.darwin = {pkgs, ...}: {
    imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];

    system.primaryUser = "howird";
    networking.computerName = "mba";
    networking.hostName = "mba";
    networking.localHostName = "mba";

    users.users.howird = {
      home = "/Users/howird";
      shell = pkgs.zsh;
    };

    nix-homebrew = {
      enable = true;
      user = "howird";
    };

    services.kanata = {
      enable = true;
      configFile = ../../../configs/keyboards/kanata/macbook.kbd;
    };
  };
}
