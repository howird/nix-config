{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hyprshot
    hyprpaper
    clipse
    # cliphist
    # wl-clip-persist
    wl-clipboard-rs
    wf-recorder
    swayidle
    glib
    wayland

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
