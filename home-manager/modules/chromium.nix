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
    commandLineArgs = if (config.myDesktop != "gnome") then
        [
          "--enable-features=UseOzonePlatform"
          "--ozone-platform=wayland"
        ]
      else
        [];
  };
}
