{inputs, ...}: {
  flake-file.inputs.zen-browser = {
    url = "github:/0xc000022070/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  # howird-only (matches the pre-migration repo's home-manager/browsers, only
  # ever imported by nixos-only.nix).
  den.aspects.browsers.homeManager = {
    lib,
    config,
    ...
  }: {
    imports = [
      ./_browsers/chromium.nix
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
      myBrowser.zen = true;
      programs.zen-browser.enable = config.myBrowser.zen;
      programs.firefox.enable = config.myBrowser.firefox;
    };
  };
}
