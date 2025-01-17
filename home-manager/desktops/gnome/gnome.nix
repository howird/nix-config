{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.myDesktop.gnome {
  home.packages = with pkgs; [
    dconf-editor
    gnome-tweaks

    networkmanager-openvpn
    networkmanager-openconnect

    # gnomeExtensions.user-themes
    # gnomeExtensions.tray-icons-reloaded
    # gnomeExtensions.vitals
    # gnomeExtensions.dash-to-panel
    # # gnomeExtensions.sound-output-device-chooser
    # gnomeExtensions.space-bar
  ];
}
