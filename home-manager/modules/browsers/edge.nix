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
      pkgs.microsoft-edge
    ];
  };
}

