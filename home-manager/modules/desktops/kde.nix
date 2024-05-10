{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf (!config.myDesktop.gnome) {

  };
}
