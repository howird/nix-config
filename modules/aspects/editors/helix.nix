{
  inputs,
  lib,
  ...
}: let
  helixModule = {pkgs, ...}: {
    imports = [
      inputs.helix-plugins.homeManagerModules.default
      ./_helix/plugins.nix
      ./_helix/languages

      ./_helix/helix.nix
      ./_helix/binds.nix
    ];

    programs.helix = {
      defaultEditor = true;
      package = pkgs.steelix;
      extraPackages = with pkgs; [steel];
    };
  };
in {
  flake-file.inputs.helix-plugins = {
    url = "git+https://codeberg.org/maxschipper/helix-plugins-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.helix.homeManager = helixModule;

  perSystem = {system, ...}: {
    packages.hx = import ./_helix/app.nix {
      inherit inputs lib system;
      module = helixModule;
    };
  };
}
