{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./chromium.nix
  ];
  options = {
    myBrowser = {
      chromium = lib.mkEnableOption "chromium";
      edge = lib.mkEnableOption "edge";
      # sometimes vivaldi's GPUCache must be cleared after an update
      # rm -rf ~/.config/vivaldi/Default/GPUCache ~/.config/vivaldi/Default/Storage/ext/**/GPUCache
      vivaldi = lib.mkEnableOption "vivaldi";
      zen = lib.mkEnableOption "zen";
      firefox = lib.mkEnableOption "firefox";
    };
  };

  config = let
    commandLineArgs = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];
  in {
    home.packages =
      lib.lists.optionals config.myBrowser.vivaldi [
        #
        (pkgs.vivaldi.override {
          inherit commandLineArgs;
          proprietaryCodecs = true;
          enableWidevine = true;
          pulseSupport = true;
        })
        pkgs.libsForQt5.qtwayland # for some reason this is needed?
      ]
      ++ lib.optional config.myBrowser.edge (pkgs.microsoft-edge.override {inherit commandLineArgs;})
      ++ lib.optional config.myBrowser.zen pkgs.zen-browser;

    programs.firefox.enable = config.myBrowser.firefox;
  };
}
