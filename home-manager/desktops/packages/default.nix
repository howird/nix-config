{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./swaync
    ./swayosd
    ./waybar
    ./uair

    ./batsignal.nix
    ./hyprlock.nix
    ./rofi.nix
    ./kanshi.nix
  ];

  home.packages = with pkgs; (lib.optionals (config.programs.hyprland.enable || config.programs.hyprland.enable) [
    hyprpaper
    wl-clipboard-rs
    glib
    wayland
    libnotify

    blueman
    networkmanagerapplet
    pavucontrol
  ]);
}
