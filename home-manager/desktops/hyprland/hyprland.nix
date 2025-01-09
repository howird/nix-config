{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    swww
    hyprshot
    clipse
    wl-clipboard-rs
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
