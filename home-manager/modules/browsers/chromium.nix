{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf (with config.myBrowser; (vivaldi || chrome)) {
    programs.chromium = {
      enable = true;
      # sometimes vivaldi's GPUCache must be cleared after an update
      # rm -rf ~/.config/vivaldi/Default/GPUCache ~/.config/vivaldi/Default/Storage/ext/**/GPUCache
      package = with config.myBrowser;
        if vivaldi
        then pkgs.vivaldi
        else pkgs.chromium;
      commandLineArgs = lib.mkIf (config.myDesktop.kde || config.myDesktop.hyprland) [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    };

    home.packages = lib.mkIf (config.myDesktop.kde || config.myDesktop.hyprland) [
      pkgs.libsForQt5.qtwayland
    ];
  };
}
