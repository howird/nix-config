{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./style.nix
  ];
  home.packages = lib.optional config.programs.niri.enable pkgs.swaynotificationcenter;
  xdg.configFile."swaync/config.json".source = ./config.json;
}
