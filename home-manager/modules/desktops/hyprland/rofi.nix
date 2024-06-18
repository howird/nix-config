{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myDesktop.hyprland {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };
}
