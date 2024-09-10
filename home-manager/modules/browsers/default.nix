{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./chromium.nix
    ./firefox.nix
  ];

  options = {
    myBrowser = {
      vivaldi = lib.mkEnableOption "vivaldi";
      chromium = lib.mkEnableOption "chromium";
      edge = lib.mkEnableOption "edge";
      floorp = lib.mkEnableOption "floorp";
    };
  };

  config = {
    home.packages = lib.mkIf config.myBrowser.edge [
      pkgs.microsoft-edge
    ];
  };
}
