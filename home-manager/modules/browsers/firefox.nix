{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myBrowser.floorp {
    programs.firefox = {
      enable = true;
      package = pkgs.floorp;
    };
  };
}
