{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myBrowser.firefox {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox;
    };
  };
}
