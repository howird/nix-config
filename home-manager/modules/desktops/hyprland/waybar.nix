{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myDesktop.hyprland {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      # settings = ;
      # style = ;
    };
  };
}
