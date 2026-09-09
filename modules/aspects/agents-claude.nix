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

  den.aspects.agents-claude.homeManager = {pkgs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    home.packages = [
      inputs.claude-desktop.packages.${system}.claude-desktop
    ];

    programs.claude-code = {
      enable = true;
      package = inputs.claude-code.packages.${system}.default;
    };
  };
}
