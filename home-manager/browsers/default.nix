{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    ./chromium.nix
    # inputs.schizofox.homeManagerModules.default
    inputs.zen-browser.homeModules.twilight
  ];
  options = {
    myBrowser = {
      chromium = lib.mkEnableOption "chromium";
      zen = lib.mkEnableOption "zen";
      firefox = lib.mkEnableOption "firefox";
    };
  };

  config = {
    programs.zen-browser.enable = config.myBrowser.zen;
    programs.firefox.enable = config.myBrowser.firefox;
    # programs.schizofox.enable = true;
  };
}
