{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.chromium = {
    enable = true;
    # sometimes vivaldi's GPUCache must be cleared after an update
    # rm -rf ~/.config/vivaldi/Default/GPUCache ~/.config/vivaldi/Default/Storage/ext/**/GPUCache
    package = pkgs.vivaldi;
    commandLineArgs = lib.mkIf (config.myDesktop.kde || config.myDesktop.hyprland) [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };

  home.packages = lib.mkIf (config.myDesktop.kde || config.myDesktop.hyprland) [
    pkgs.libsForQt5.qtwayland
  ];
}
