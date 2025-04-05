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
      "HDMI-A-1, 1920x1080@60, 0x0, 1"
    ];
  };
}
