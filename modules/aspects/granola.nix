{inputs, ...}: {
  flake-file.inputs.granola = {
    url = "github:howird/granola-flake";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
  };

  # howird-only (matches den.aspects.apps/browsers - a workstation-only app).
  den.aspects.granola.homeManager = {pkgs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    home.packages = [
      inputs.granola.packages.${system}.granola
    ];

    # NixOS manages ~/.config/mimeapps.list as a read-only symlink into the
    # store, so a runtime `xdg-mime default` can never persist there - the
    # granola:// OAuth sign-in callback needs this declared here instead.
    xdg.mimeApps.defaultApplications."x-scheme-handler/granola" = "granola.desktop";
  };
}
