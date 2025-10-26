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
    ./record

    ./clipse.nix
    ./batsignal.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./rofi.nix
    ./kanshi.nix
  ];

  services.swww.enable = config.programs.niri.enable;
  home.packages = lib.optionals config.programs.niri.enable (with pkgs; [
    glib
    wayland
    libnotify

    blueman
    networkmanagerapplet
    pavucontrol
  ]);
}
