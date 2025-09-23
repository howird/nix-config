{pkgs, ...}: {
  # home.packages = with pkgs; [
  #   hyprpaper
  #   wl-clipboard-rs
  #   glib
  #   wayland
  #   libnotify
  #
  #   blueman
  #   networkmanagerapplet
  #   pavucontrol
  # ];

  programs.niri = {
    enable = true;
  };
}
