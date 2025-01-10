{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home-manager
    ../../home-manager/nixos-only.nix
  ];
}
