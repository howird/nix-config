{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = let
    enable = config.myDesktop == "hyprland";
  in {
    xdg.portal.wlr.enable = enable;
    programs.hyprland = {
      enable = enable;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      xwayland.enable = enable;
    };
  };
}
