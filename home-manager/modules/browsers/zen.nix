{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    home.packages = lib.mkIf config.myBrowser.zen [
      inputs.zen-browser.packages."${pkgs.system}".default
    ];
  };
}

