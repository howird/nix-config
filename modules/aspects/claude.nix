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
  flake-file.inputs.mattpocock-skills = {
    url = "github:mattpocock/skills";
    flake = false;
  };

  den.aspects.claude.homeManager = {
    config,
    pkgs,
    lib,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      inputs.claude-desktop.packages.${system}.claude-desktop
    ];

    programs.claude-code = {
      enable = true;
      package = inputs.claude-code.packages.${system}.default;
      enableMcpIntegration = true;
    };

    home.file."${config.programs.claude-code.configDir}/skills/mattpocock-skills".source = inputs.mattpocock-skills;
  };
}
