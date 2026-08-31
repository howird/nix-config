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
  flake-file.inputs.pi = {
    url = "github:lukasl-dev/pi.nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.editors-agents.homeManager = {pkgs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    home.packages = with pkgs; [
      inputs.pi.packages.${system}.default

      inputs.claude-desktop.packages.${system}.claude-desktop
      inputs.claude-code.packages.${system}.default

      kiro-fhs
      kiro-cli

      antigravity-cli
    ];
  };
}
