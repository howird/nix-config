{
  inputs,
  lib,
  ...
}: let
  # pkgs.helixPlugins comes from inputs.helix-plugins.overlays.default, added
  # in nixpkgs-settings (and vip's standalone pkgs).
  helixModule = {pkgs, ...}: {
    imports = [
      inputs.helix-plugins.homeManagerModules.default

      ./_helix/languages

      ./_helix/helix.nix
      ./_helix/binds.nix
    ];

    programs.helix = {
      defaultEditor = true;
      package = pkgs.steelix;
      extraPackages = with pkgs; [steel];
      plugins = with pkgs.helixPlugins; [
        oil-hx
        inputs.math-hx.packages.${pkgs.stdenv.hostPlatform.system}.math-hx
        (helix-file-watcher.overrideAttrs {
          postPatch = ''
            substituteInPlace file-watcher.scm --replace-fail \
              '(watch-file! watch-handle x)) paths)' \
              '(watch-file! watch-handle x)) (hashset->list (list->hashset (map parent-name paths))))'
          '';
        })
      ];
    };

    xdg.configFile."helix/init.scm".source = ./_helix/init.scm;
  };
in {
  flake-file.inputs.helix-plugins = {
    url = "git+https://codeberg.org/maxschipper/helix-plugins-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake-file.inputs.math-hx = {
    url = "github:howird/math.hx";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      helix-plugins.follows = "helix-plugins";
    };
  };

  den.aspects.helix.homeManager = helixModule;

  perSystem = {system, ...}: {
    packages.hx = import ./_helix/app.nix {
      inherit inputs lib system;
      module = helixModule;
    };
  };
}
