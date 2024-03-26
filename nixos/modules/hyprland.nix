{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  xdg.portal.wlr.enable = true;
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };
}
