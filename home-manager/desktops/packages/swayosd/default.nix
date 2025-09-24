{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./styles.nix
    ./hyprland.nix
  ];

  # services.swayosd.enable = config.myDesktop.hyprland;
  home.packages = lib.optional (config.programs.niri.enable || config.programs.hyprland.enable) pkgs.swayosd;
}
