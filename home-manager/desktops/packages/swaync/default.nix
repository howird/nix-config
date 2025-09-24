{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./style.nix
  ];
  home.packages = lib.optional (config.programs.niri.enable || config.programs.hyprland.enable) pkgs.swaynotificationcenter;
  xdg.configFile."swaync/config.json".source = ./config.json;
}
