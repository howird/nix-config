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
    ./record

    ./clipse.nix
    ./batsignal.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./rofi.nix
    ./kanshi.nix
  ];

  home.packages = with pkgs; (lib.optionals (config.programs.hyprland.enable || config.programs.hyprland.enable) [
    hyprpaper
    glib
    wayland
    libnotify

    blueman
    networkmanagerapplet
    pavucontrol
  ]);
}
