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
      floorp = lib.mkEnableOption "floorp";
    };
  };

  config = {
    myBrowser.vivaldi = true;
    myBrowser.floorp = true;
  };
}
