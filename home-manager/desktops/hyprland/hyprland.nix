{
  config,
  pkgs,
  lib,
  ...
}:
lib.mkIf config.myDesktop.hyprland {
  home.packages = with pkgs; [
    hyprshot
    hyprpaper
    clipse
    # cliphist
    # wl-clip-persist
    wl-clipboard-rs
    wf-recorder
    glib
    wayland
    libnotify
    file-roller

    nautilus
    blueman
    networkmanagerapplet
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
  };
}
