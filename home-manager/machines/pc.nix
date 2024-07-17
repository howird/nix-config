{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../home-desktop.nix
  ];
}
