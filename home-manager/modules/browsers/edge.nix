{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    home.packages = lib.mkIf config.myBrowser.edge [
      (pkgs.microsoft-edge.override {
        commandLineArgs =
          if (config.myDesktop.kde || config.myDesktop.hyprland)
          then [
            "--enable-features=UseOzonePlatform"
            "--ozone-platform=wayland"
          ]
          else [];
      })
    ];
  };
}
