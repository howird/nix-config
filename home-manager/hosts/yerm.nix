{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../home-desktop.nix
  ];
  config = {
    wayland.windowManager.hyprland.settings.monitor = [
      "eDP-1, 2256x1504, 0x0, 1.6"
    ];
  };
}
