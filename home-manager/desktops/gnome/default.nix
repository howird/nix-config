{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./gnome.nix
    ./dconf.nix
  ];
}
