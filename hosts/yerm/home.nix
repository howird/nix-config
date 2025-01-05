{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home-manager
    ../../home-manager/nixos-only.nix
  ];
  config = {
    wayland.windowManager.hyprland.settings.monitor = [
      "eDP-1, 2256x1504, 0x0, 1.6"
    ];
    home.sessionVariables.GDK_SCALE = "1.6";
  };
}
