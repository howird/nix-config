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
    ./zen.nix
    ./edge.nix
  ];

  options = {
    myBrowser = {
      vivaldi = lib.mkEnableOption "vivaldi";
      chromium = lib.mkEnableOption "chromium";
      edge = lib.mkEnableOption "edge";
      zen = lib.mkEnableOption "zen";
      firefox = lib.mkEnableOption "firefox";
    };
  };
}
