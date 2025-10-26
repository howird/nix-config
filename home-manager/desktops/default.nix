{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./niri
    ./packages
  ];

  config.home.packages = with pkgs; [
    wl-clipboard-rs
    slurp
    grim
  ];

  options.programs = {
    niri.enable = lib.mkEnableOption "niri";
  };
}
