{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    swww
    hyprpicker
    hyprshot
    wl-clip-persist
    cliphist
    wf-recorder
    glib
    wayland

    nautilus
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
