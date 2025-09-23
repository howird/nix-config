{
  config,
  pkgs,
  lib,
  ...
}:
lib.mkIf config.myDesktop.hyprland {
  home.packages = with pkgs; [
    hyprpaper
    wl-clipboard-rs
    glib
    wayland
    libnotify

    blueman
    networkmanagerapplet
    pavucontrol
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];

  wayland.windowManager.hyprland = {
    enable = true;
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
