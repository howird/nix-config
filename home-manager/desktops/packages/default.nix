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

  services.swww.enable = config.programs.niri.enable;
  home.packages = with pkgs; (lib.optionals (config.programs.niri.enable || config.programs.hyprland.enable) [
    glib
    wayland
    libnotify

    blueman
    networkmanagerapplet
    pavucontrol
  ]);
}
