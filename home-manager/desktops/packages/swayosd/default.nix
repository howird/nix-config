{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./styles.nix
    ./niri.nix
  ];

  home.packages = lib.optional config.programs.niri.enable pkgs.swayosd;
}
