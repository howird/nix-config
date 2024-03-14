{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.unstable.rofi-wayland;
  };
}