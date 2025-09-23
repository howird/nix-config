{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; (lib.optionals programs.gnome-shell.enable [
    dconf-editor
    gnome-tweaks

    # gnomeExtensions.user-themes
    # gnomeExtensions.tray-icons-reloaded
    # gnomeExtensions.vitals
    # gnomeExtensions.dash-to-panel
    # # gnomeExtensions.sound-output-device-chooser
    # gnomeExtensions.space-bar
  ]);
}
