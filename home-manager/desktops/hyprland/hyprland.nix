{
  config,
  pkgs,
  lib,
  ...
}: let
  hyprland = config.wayland.windowManager.hyprland.enable;
in {
  home.packages = with pkgs; (lib.optionals hyprland [
    hyprpaper
    wl-clipboard-rs
    glib
    wayland
    libnotify

    blueman
    networkmanagerapplet
    pavucontrol
  ]);

  systemd.user.targets.hyprland-session.Unit.Wants = lib.optional hyprland "xdg-desktop-autostart.target";

  wayland.windowManager.hyprland = lib.mkIf hyprland {
    xwayland = {
      enable = true;
    };
    systemd.enable = true;
    systemd.variables = ["--all"];
    plugins = with pkgs; [
      hyprscrolling
      hyprexpo
    ];
  };
}
