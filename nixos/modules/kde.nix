{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = false;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # environment.variables.QT_QPA_PLATFORM_PLUGIN_PATH = ''
  #   ${pkgs.libsForQt5.qt5.qtbase.bin}/lib/qt-${pkgs.libsForQt5.qt5.qtbase.version}/plugins
  # '';
  # environment.variables.QT_PLUGIN_PATH = ''
  #   ${pkgs.libsForQt5.qt5.qtbase.bin}/lib/qt-${pkgs.libsForQt5.qt5.qtbase.version}/plugins
  # '';

}
