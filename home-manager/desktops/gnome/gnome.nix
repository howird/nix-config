{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    dconf-editor
    gnome-tweaks

    gnome.networkmanager-openvpn
    gnome.networkmanager-openconnect

    # gnomeExtensions.user-themes
    # gnomeExtensions.tray-icons-reloaded
    # gnomeExtensions.vitals
    # gnomeExtensions.dash-to-panel
    # # gnomeExtensions.sound-output-device-chooser
    # gnomeExtensions.space-bar
  ];
}
