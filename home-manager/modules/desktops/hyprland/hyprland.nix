{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    swww
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    hyprpicker
    grim
    slurp
    wl-clip-persist
    cliphist
    wf-recorder
    glib
    wayland

    nautilus
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