{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    # settings = ;
    # style = ;
  };
}
