{inputs, ...}: {
  flake-file.inputs.claude-desktop = {
    url = "github:heytcass/claude-desktop-linux-flake";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
  };
  flake-file.inputs.claude-code = {
    url = "github:ryoppippi/nix-claude-code";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.claude.homeManager = {pkgs, ...}: {
    programs.claude-code = {
      enable = true;
      package = inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default;
      mutableSettings = true;
      settings = {
        autoMemoryEnabled = false;
        idleCompaction = false;
        attribution = {
          commit = "";
          pr = "";
        };
      };
      context = ''
        @~/AGENTS.md
      '';
    };
  };

  den.aspects.claude-desktop.homeManager = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop
    ];
  };
}
